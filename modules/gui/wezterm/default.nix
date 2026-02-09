{
  flake.modules.homeManager.gui = {
    config,
    pkgs,
    ...
  }: {
    xdg = {
      configFile = {
        "wezterm/wezterm.lua".source = ./config.lua;
        "wezterm/workspace.lua".source = ./workspace.lua;
      };
      dataFile."wezterm-types".source = pkgs.local.wezterm-types;
    };

    stylix.targets.wezterm.enable = false;

    programs.wezterm = {
      enable = true;
      colorSchemes.stylix = with config.lib.stylix.colors.withHashtag; {
        ansi = [
          base00
          base08
          base0B
          base0A
          base0D
          base0E
          base0C
          base05
        ];
        brights = [
          base03
          base08
          base0B
          base0A
          base0D
          base0E
          base0C
          base07
        ];
        background = base00;
        foreground = base05;
        cursor_bg = base06;
        cursor_border = base06;
        cursor_fg = base01;
        selection_fg = base00;
        selection_bg = base0D;
        tab_bar = {
          background = base01;
          active_tab = {
            bg_color = base0D;
            fg_color = base00;
            intensity = "Bold";
          };
          inactive_tab = {
            bg_color = base01;
            fg_color = base06;
          };
          inactive_tab_hover = {
            bg_color = base01;
            fg_color = base06;
            italic = false;
          };
        };
      };
    };
  };
}
