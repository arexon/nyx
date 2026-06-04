{
  flake.modules.homeManager.gui = {config, ...}: {
    stylix.targets.firefox.enable = false;

    programs.firefox = {
      enable = true;
      # Due to home.stateVersion being 25.11
      configPath = "${config.xdg.configHome}/mozilla/firefox";
    };
  };
}
