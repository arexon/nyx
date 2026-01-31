{
  lib,
  pkgs,
  ...
}: let
  inherit (lib) getExe;

  denoFormatter = ext: {
    command = "deno";
    args = ["fmt" "-" "--ext" ext];
  };

  harper = getExe pkgs.harper;
  copilot = getExe pkgs.copilot-language-server;
  marksman = getExe pkgs.marksman;
  nixd = getExe pkgs.nixd;
  alejandra = getExe pkgs.alejandra;
  color-lsp = getExe pkgs.color-lsp;
in {
  stylix.targets.helix.enable = false;

  xdg.desktopEntries.Helix = {
    name = "";
    noDisplay = true;
  };

  programs.helix = {
    enable = true;
    defaultEditor = true;

    languages = {
      language-server = {
        rust-analyzer.config = {
          check.command = "clippy";
          cargo.features = "all";
          diagnostics.disabled = ["macro-error"];
        };
        nixd.command = nixd;
        marksman.command = marksman;
        harper = {
          command = harper;
          args = ["--stdio"];
        };
        deno-lsp = {
          command = "deno";
          args = ["lsp"];
          config.deno.inlayHints = {
            enumMemberValues.enabled = true;
            functionLikeReturnTypes.enabled = true;
            parameterNames.enabled = "all";
            parameterTypes.enabled = true;
            propertyDeclarationTypes.enabled = true;
            variableTypes.enabled = true;
          };
        };
        color-lsp.command = color-lsp;
        copilot = {
          command = copilot;
          args = ["--stdio"];
          config = {
            editorInfo = {
              name = "Helix";
              version = "25.07.1";
            };
            editorPluginInfo = {
              name = "helix-copilot";
              version = "0.1.0";
            };
          };
        };
      };
      language = [
        {
          name = "rust";
          language-servers = ["rust-analyzer"];
          auto-pairs = {
            "(" = ")";
            "{" = "}";
            "[" = "]";
            "\"" = "\"";
          };
        }
        {
          name = "nix";
          formatter.command = alejandra;
          auto-format = true;
          language-servers = ["nixd" "color-lsp"];
        }
        {
          name = "markdown";
          auto-format = true;
          language-servers = ["marksman" "harper"];
          formatter = denoFormatter "md";
        }
        {
          name = "typescript";
          formatter = denoFormatter "ts";
          auto-format = true;
          language-servers = ["typescript-language-server" "deno-lsp" "color-lsp" "copilot"];
        }
        {
          name = "javascript";
          formatter = denoFormatter "js";
          auto-format = true;
          language-servers = ["typescript-language-server" "deno-lsp" "color-lsp"];
        }
        {
          name = "jsonc";
          formatter = denoFormatter "jsonc";
          file-types = [
            "jsonc"
            "json"
            "templ"
            {glob = "tsconfig.json";}
            {glob = "bun.lock";}
            {glob = "flake.lock";}
          ];
          language-servers = ["vscode-json-language-server" "color-lsp"];
        }
        {
          name = "yaml";
          formatter = denoFormatter "yml";
        }
        {
          name = "toml";
          auto-format = true;
          language-servers = ["taplo" "color-lsp"];
        }
        {
          name = "lua";
          auto-format = true;
          language-servers = [
            {
              name = "lua-language-server";
              except-features = ["format"];
            }
          ];
          formatter = {
            command = "stylua";
            args = ["-"];
          };
        }
      ];
    };

    settings = {
      theme = "custom";
      editor = {
        line-number = "relative";
        bufferline = "never";
        true-color = true;
        auto-info = false;
        auto-format = true;
        rainbow-brackets = true;
        end-of-line-diagnostics = "error";
        inline-diagnostics = {
          cursor-line = "info";
          other-lines = "disable";
        };
        completion-trigger-len = 1;
        indent-guides.render = true;
        cursor-shape = {
          insert = "bar";
          select = "underline";
        };
        statusline = {
          left = [
            "mode"
            "file-name"
            "file-modification-indicator"
            "read-only-indicator"
            "spacer"
            "version-control"
          ];
          right = [
            "spinner"
            "spacer"
            "diagnostics"
            "workspace-diagnostics"
            "spacer"
            "primary-selection-length"
            "spacer"
            "position"
            "position-percentage"
            "spacer"
          ];
        };
        lsp.display-messages = true;
      };
      keys = {
        normal = {
          x = "extend_line";
          esc = ["collapse_selection" "keep_primary_selection"];
          "C-u" = ["half_page_up" "align_view_center"];
          "C-d" = ["half_page_down" "align_view_center"];
          "A-x" = [":reset-diff-change"];
          Y = [":yank-join"];
          "C-s" = ":write";
          "C-q" = ":buffer-close";
          "C-S-q" = ":quit-all!";
          "C-S-r" = ":reload-all";
          "C-r" = ":reload";
        };
        insert = {
          "C-[" = "normal_mode";
          "A-y" = "inline_completion_accept";
          "A-n" = "inline_completion_dismiss";
        };
        select = {
          x = "extend_line";
          ";" = ["collapse_selection" "normal_mode"];
        };
      };
    };

    themes.custom = {
      inherits = "catppuccin_mocha";
      special = "green";
      rainbow = ["red" "peach" "yellow" "green" "sapphire"];
      "ui.background" = {};
    };
  };
}
