{
  flake.modules.homeManager.gui = {pkgs, ...}: {
    stylix.targets.wezterm.enable = true;

    xdg = {
      configFile = {
        "wezterm/wezterm.lua".source = ./config.lua;
        "wezterm/workspace.lua".source = ./workspace.lua;
      };
      dataFile."wezterm-types".source = pkgs.wezterm-types;
    };

    programs.wezterm.enable = true;
  };
}
