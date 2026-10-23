{
  flake.modules.darwin.gui = {
    homebrew.casks = ["zed"];
  };

  flake.modules.homeManager.gui = {
    lib,
    pkgs,
    ...
  }: let
    inherit (pkgs.stdenv.hostPlatform) isDarwin;

    fontSize = 19;
    noLigatures = {
      calt = false;
      liga = false;
    };

    formatWith = command: arguments: {
      format_on_save = "on";
      formatter.external = {
        inherit command arguments;
      };
    };
    denoFormatter = ext: formatWith "deno" ["fmt" "-" "--ext" ext];
  in {
    programs.zed-editor = {
      enable = true;
      package =
        if isDarwin
        then null
        else pkgs.zed-editor;

      extensions = [
        "catppuccin"
        "catppuccin-icons"
        "nix"
        "toml"
        "lua"
        "oxc"
        "tsgo"
        "git-firefly"
      ];

      userSettings = {
        helix_mode = true;
        relative_line_numbers = "enabled";
        colorize_brackets = true;
        diagnostics.inline.enabled = true;

        theme = {
          light = "Catppuccin Latte";
          dark = "Catppuccin Mocha";
        };
        icon_theme = "Catppuccin Mocha";

        ui_font_size = fontSize;
        buffer_font_size = fontSize;
        agent_ui_font_size = fontSize;
        agent_buffer_font_size = fontSize;
        git_commit_buffer_font_size = fontSize;
        markdown_preview.font_size = fontSize;
        buffer_font_family = "Iosevka NF";
        buffer_font_features = noLigatures;
        buffer_line_height = "standard";

        terminal = {
          font_features = noLigatures;
          shell.program = "fish";
          button = false;
          default_height = 480;
        };

        toolbar = {
          breadcrumbs = false;
          quick_actions = false;
          selections_menu = false;
          agent_review = false;
        };
        edit_predictions.provider = "none";
        tab_bar = {
          show_tab_bar_buttons = false;
          show_nav_history_buttons = false;
        };
        tabs.git_status = true;
        preview_tabs.enable_preview_multibuffer_from_code_navigation = true;
        status_bar = {
          line_endings_button = true;
          active_encoding_button = "enabled";
        };
        title_bar = {
          show_sign_in = false;
          show_user_menu = false;
        };
        git_panel = {
          dock = "left";
          group_by = "staging";
          tree_view = true;
        };
        project_panel = {
          dock = "left";
          default_width = 360;
          hide_root = true;
          git_status_indicator = true;
          diagnostic_badges = true;
        };
        outline_panel = {
          dock = "left";
          button = false;
          default_width = 360;
        };
        collaboration_panel = {
          button = false;
          default_width = 360;
        };
        debugger.button = false;
        search.button = false;

        auto_update = false;
        session.trust_all_worktrees = true;
        telemetry = {
          diagnostics = false;
          metrics = false;
        };
        agent = {
          dock = "right";
          threads_sidebar = {
            position = "right";
            auto_open = false;
          };
          notify_when_agent_waiting = "never";
          play_sound_when_agent_done = "when_hidden";
          flexible = false;
          default_width = 480;
          enable_feedback = false;
          expand_edit_card = false;
          expand_terminal_card = false;
          thinking_display = "always_collapsed";
        };
        agent_servers.claude-acp = {
          type = "registry";
          default_config_options.mode = "auto";
        };

        # Zed otherwise downloads its own older Node for Node-based language servers.
        node.path = lib.getExe pkgs.nodejs_26;

        file_types.JSONC = ["templ"];

        languages = {
          Nix =
            formatWith "alejandra" ["--quiet" "-"]
            // {language_servers = ["nixd" "!nil"];};
          Lua = formatWith "stylua" ["-"];
          Markdown = denoFormatter "md";
          TypeScript = denoFormatter "ts";
          JavaScript = denoFormatter "js";
        };
      };
    };
  };
}
