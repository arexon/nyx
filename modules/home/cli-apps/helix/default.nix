{
  config,
  pkgs,
  lib,
  inputs,
  system,
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
  nixd = "${pkgs.nixd}/bin/nixd";
  alejandra = "${pkgs.alejandra}/bin/alejandra";
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
      package = inputs.helix-editor.packages.${system}.default;
      defaultEditor = true;
      languages = {
        language-server = {
          rust-analyzer.config = {
            check.command = "clippy";
            cargo.features = "all";
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
            language-servers = ["nixd"];
          }
          {
            name = "markdown";
            formatter = dprintFormatter "md";
            auto-format = true;
            language-servers = ["marksman" "harper"];
          }
          {
            name = "typescript";
            formatter = {
              command = "deno";
              args = ["fmt" "-"];
            };
            auto-format = true;
            roots = ["deno.json" "deno.jsonc" "package.json"];
            language-servers = ["typescript-language-server" "deno-lsp"];
          }
          {
            name = "javascript";
            formatter = dprintFormatter "js";
            auto-format = true;
            language-servers = ["typescript-language-server" "deno-lsp"];
          }
          {
            name = "json";
            formatter = dprintFormatter "json";
            auto-format = true;
            language-servers = ["vscode-json-language-server"];
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
              "file-name"
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
            space.l = ":toggle lsp.display-inlay-hints";
          };
          insert = {
            "C-[" = ["normal_mode"];
          };
          select = {
            x = "extend_line";
            ";" = ["collapse_selection" "normal_mode"];
          };
        };
      };
    };
  };
}
