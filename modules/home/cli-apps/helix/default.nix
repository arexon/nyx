{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.nyx.cli-apps.helix;

  theme = config.colorscheme.slug;

  dprintFormatter = lang: {
    command = "dprint";
    args = [
      "fmt"
      "--stdin"
      lang
    ];
  };

  harper = "${pkgs.harper}/bin/harper-ls";
  marksman = "${pkgs.marksman}/bin/marksman";
in {
  options.nyx.cli-apps.helix = {
    enable = mkBoolOpt false "Whether to enable Helix editor.";
  };

  config = mkIf cfg.enable {
    xdg.desktopEntries.Helix = {
      name = "";
      noDisplay = true;
    };

    programs.helix = {
      enable = true;
      defaultEditor = true;
      languages = {
        language-server = {
          marksman.command = marksman;
          harper = {
            command = harper;
            args = ["--stdio"];
          };
        };

        language = [
          {
            name = "rust";
            language-servers = ["rust-analyzer" "harper"];
          }
          {
            name = "nix";
            indent = {
              tab-width = 2;
              unit = " ";
            };
            formatter.command = "alejandra";
            auto-format = true;
            language-servers = ["nil" "harper"];
          }
          {
            name = "markdown";
            formatter = dprintFormatter "md";
            auto-format = true;
            language-servers = ["marksman" "harper"];
          }
          {
            name = "typescript";
            formatter = dprintFormatter "ts";
            auto-format = true;
            language-servers = ["typescript-language-server" "harper"];
          }
          {
            name = "javascript";
            formatter = dprintFormatter "js";
            auto-format = true;
            language-servers = ["typescript-language-server" "harper"];
          }
          {
            name = "json";
            formatter = dprintFormatter "json";
            auto-format = true;
            language-servers = ["vscode-json-language-server" "harper"];
          }
          {
            name = "toml";
            auto-format = true;
          }
        ];
      };
      settings = {
        inherit theme;

        editor = {
          line-number = "relative";
          bufferline = "always";
          true-color = true;
          auto-info = false;
          auto-format = true;
          completion-trigger-len = 1;
          indent-guides.render = true;
          cursor-shape = {
            insert = "bar";
            select = "underline";
          };
          statusline = {
            left = ["mode" "spacer" "file-name" "spacer" "version-control"];
            right = [
              "spacer"
              "diagnostics"
              "spacer"
              "spinner"
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
            space.l = ":toggle lsp.display-inlay-hints";
          };
          insert = {
            "C-[" = ["normal_mode"];
          };
          select = {
            x = "extend_line";
          };
        };
      };
    };
  };
}
