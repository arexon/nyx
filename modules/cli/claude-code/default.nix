{inputs, ...}: {
  flake-file.inputs = {
    agent-style = {
      url = "github:yzhao062/agent-style";
      flake = false;
    };
  };

  flake.modules.homeManager.cli = {
    pkgs,
    lib,
    config,
    ...
  }: let
    # Claude Code sources $CLAUDE_ENV_FILE before every Bash command, so this
    # line reruns direnv each time and picks up edits to flake.nix mid-session.
    direnvHook = pkgs.writeShellScript "claude-direnv-env" ''
      [ -n "$CLAUDE_ENV_FILE" ] || exit 0
      echo 'eval "$(${lib.getExe config.programs.direnv.package} export bash 2>/dev/null)"' >> "$CLAUDE_ENV_FILE"
    '';
  in {
    programs.claude-code = {
      enable = true;
      context = ./CLAUDE.md;

      skills = {
        agent-style = "${inputs.agent-style}/agents/anthropic-skill";
        api-docs = ./skills/api-docs;
      };

      mutableSettings = true;
      settings = {
        autoMemoryEnabled = false;
        spinnerTipsEnabled = false;
        awaySummaryEnabled = false;
        theme = "dark-ansi";

        hooks.SessionStart = [
          {
            hooks = [
              {
                type = "command";
                command = "${direnvHook}";
              }
            ];
          }
        ];
      };
    };
  };
}
