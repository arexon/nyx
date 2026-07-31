{
  flake.modules.darwin.ai = {
    pkgs,
    lib,
    ...
  }: {
    networking.applicationFirewall.enable = true;
    networking.applicationFirewall.blockAllIncoming = false;

    system.activationScripts.extraActivation.text = ''
      echo "allowing llama-server through application firewall..." >&2
      /usr/libexec/ApplicationFirewall/socketfilterfw --add ${lib.getExe' pkgs.llama-cpp "llama-server"} || true
      /usr/libexec/ApplicationFirewall/socketfilterfw --unblockapp ${lib.getExe' pkgs.llama-cpp "llama-server"} || true
    '';
  };

  flake.modules.homeManager.ai = {
    config,
    pkgs,
    lib,
    ...
  }: let
    modelsDir = "${config.home.homeDirectory}/Models";
    configPath = "${modelsDir}/config.toml";
    host = "0.0.0.0";
    port = 1337;
    baseUrl = "http://127.0.0.1:${toString port}";
    agentLabel = "org.nix-community.home.llama-server";

    llama-server-router = pkgs.writeShellApplication {
      name = "llama-server-router";
      runtimeInputs = with pkgs; [llama-cpp yq-go jq coreutils];
      text = ''
        set -euo pipefail

        models_dir=${lib.escapeShellArg modelsDir}
        config_toml=${lib.escapeShellArg configPath}
        host=${lib.escapeShellArg host}
        port=${lib.escapeShellArg (toString port)}

        if [[ ! -f "$config_toml" ]]; then
          echo "missing $config_toml" >&2
          exit 1
        fi

        preset="$(mktemp -t llama-models.XXXXXX.ini)"
        trap 'rm -f "$preset"' EXIT

        yq -p=toml -o=json '.' "$config_toml" | jq -r '
          def fmt:
            if type == "boolean" then (if . then "true" else "false" end)
            else tostring end;
          def section(name; obj):
            (["[\(name)]"] + (obj | to_entries | map("\(.key) = \(.value | fmt)"))) | .[];
          "version = 1",
          "",
          section("*"; (.defaults // {}) * {"load-on-startup": ((.defaults // {})["load-on-startup"] // false)}),
          "",
          ((.models // {}) | to_entries[] |
            section(.key; .value * {"load-on-startup": (.value["load-on-startup"] // false)}),
            "")
        ' >"$preset"

        exec llama-server \
          --models-dir "$models_dir" \
          --models-preset "$preset" \
          --no-models-autoload \
          --models-max 1 \
          --host "$host" \
          --port "$port"
      '';
    };

    llama-ctl = pkgs.writeShellApplication {
      name = "llama-ctl";
      runtimeInputs = with pkgs; [curl jq];
      text = ''
        set -euo pipefail

        base_url=${lib.escapeShellArg baseUrl}
        agent=${lib.escapeShellArg agentLabel}
        uid="$(id -u)"

        usage() {
          cat <<EOF
        usage: llama-ctl <command> [args]

          service:
            status             show launchd + router status
            start              start launchd agent
            stop               stop launchd agent
            restart            restart launchd agent

          models (web UI: $base_url)
            list               list known models
            load <model>       load a model
            unload <model>     unload a model

          config: ${configPath}
        EOF
        }

        api() {
          local method=$1 path=$2
          shift 2
          curl -fsS -X "$method" "$base_url$path" \
            -H 'Content-Type: application/json' \
            "$@"
        }

        require_router() {
          if ! curl -fsS "$base_url/health" >/dev/null 2>&1; then
            echo "llama-server is not reachable at $base_url" >&2
            echo "try: llama-ctl start" >&2
            exit 1
          fi
        }

        cmd=''${1:-}
        shift || true

        case "$cmd" in
          status)
            launchctl print "gui/$uid/$agent" 2>/dev/null || echo "launchd agent not loaded"
            if curl -fsS "$base_url/health" >/dev/null 2>&1; then
              echo "router: up ($base_url)"
              api GET /models | jq .
            else
              echo "router: down ($base_url)"
            fi
            ;;
          start)
            launchctl bootstrap "gui/$uid" "$HOME/Library/LaunchAgents/$agent.plist" 2>/dev/null || true
            launchctl kickstart -k "gui/$uid/$agent"
            ;;
          stop)
            launchctl bootout "gui/$uid/$agent" 2>/dev/null || true
            ;;
          restart)
            "$0" stop || true
            sleep 1
            "$0" start
            ;;
          list)
            require_router
            api GET /models | jq .
            ;;
          load)
            require_router
            model=''${1:?model id required}
            api POST /models/load -d "$(jq -n --arg m "$model" '{model:$m}')"
            echo
            ;;
          unload)
            require_router
            model=''${1:?model id required}
            api POST /models/unload -d "$(jq -n --arg m "$model" '{model:$m}')"
            echo
            ;;
          ""|-h|--help|help)
            usage
            ;;
          *)
            echo "unknown command: $cmd" >&2
            usage >&2
            exit 1
            ;;
        esac
      '';
    };
  in {
    home.packages = [llama-ctl];

    launchd.agents.llama-server = {
      enable = true;
      config = {
        ProgramArguments = [(lib.getExe llama-server-router)];
        RunAtLoad = true;
        KeepAlive = true;
        ProcessType = "Interactive";
        StandardOutPath = "/tmp/llama-server.log";
        StandardErrorPath = "/tmp/llama-server.err";
      };
    };
  };
}
