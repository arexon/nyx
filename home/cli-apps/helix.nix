{
  config,
  pkgs,
  lib,
  inputs,
  system,
  ...
}:
with lib; let
  theme = config.colorscheme.slug;

  denoFormatter = ext: {
    command = "deno";
    args = ["fmt" "-" "--ext" ext];
  };

  harper = "${pkgs.harper}/bin/harper-ls";
  marksman = "${pkgs.marksman}/bin/marksman";
  nixd = "${pkgs.nixd}/bin/nixd";
  alejandra = "${pkgs.alejandra}/bin/alejandra";
  luals = "${pkgs.lua-language-server}/bin/lua-language-server";
  stylua = "${pkgs.stylua}/bin/stylua";

  wezterm-types = pkgs.stdenv.mkDerivation rec {
    pname = "wezterm-types";
    version = "1.0.0";
    src = pkgs.fetchFromGitHub {
      owner = "justinsgithub";
      repo = pname;
      rev = "d275d9f1811a259788468a5550ff6daf25f956bf";
      sha256 = "sha256-nQuYeXB5bfHiYbJI/eGwKUiwBOc8GK3q2FDcOgB3Pcc=";
    };
    installPhase = ''
      mkdir -p $out
      cp -r $src/* $out
    '';
  };
in {
  programs.helix = {
    enable = true;
    package = let
      helixPkg = inputs.helix-editor.packages.${system}.default;
    in
      helixPkg.overrideAttrs (_: {
        # This is required for removing the Desktop icon.
        postInstall = "";
      });
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
        lua-language-server = {
          command = luals;
          config.Lua = {
            runtime.version = "LuaJIT";
            workspace.library = [wezterm-types];
          };
        };
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
          auto-format = true;
          language-servers = ["marksman" "harper"];
        }
        {
          name = "typescript";
          formatter = denoFormatter "ts";
          auto-format = true;
          language-servers = ["typescript-language-server" "deno-lsp"];
        }
        {
          name = "javascript";
          formatter = denoFormatter "js";
          auto-format = true;
          language-servers = ["typescript-language-server" "deno-lsp"];
        }
        {
          name = "jsonc";
          formatter = {
            command = "prettier";
            args = ["--parser" "json"];
          };
          file-types = [
            "jsonc"
            "json"
            "templ"
            {glob = "tsconfig.json";}
            {glob = "bun.lock";}
            {glob = "flake.lock";}
          ];
        }
        {
          name = "toml";
          auto-format = true;
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
            command = stylua;
            args = ["-"];
          };
        }
      ];
    };
    settings = {
      inherit theme;
      editor = {
        line-number = "relative";
        bufferline = "never";
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
          space.l = ":toggle lsp.display-inlay-hints";
          Y = [":yank-join"];
          "1" = [":harpoon_update" ":harpoon_get 1"];
          "2" = [":harpoon_update" ":harpoon_get 2"];
          "3" = [":harpoon_update" ":harpoon_get 3"];
          "4" = [":harpoon_update" ":harpoon_get 4"];
          "A-h" = {
            "1" = ":harpoon_set 1";
            "2" = ":harpoon_set 2";
            "3" = ":harpoon_set 3";
            "4" = ":harpoon_set 4";
            l = ":harpoon_list";
          };
          g = {
            w = ["save_selection" "goto_word"];
            n = [":harpoon_update" "goto_next_buffer"];
            p = [":harpoon_update" "goto_previous_buffer"];
            d = [":harpoon_update" "goto_definition"];
            y = [":harpoon_update" "goto_type_definition"];
            r = [":harpoon_update" "goto_reference"];
          };
          "C-s" = ":write";
          "C-q" = ":buffer-close";
          "C-S-r" = ":reload-all";
          "C-r" = ":reload";
        };
        insert = {
          "C-[" = "normal_mode";
        };
        select = {
          x = "extend_line";
          ";" = ["collapse_selection" "normal_mode"];
        };
      };
    };
  };
}
