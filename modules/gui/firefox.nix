{
  flake.modules.homeManager.gui = {
    stylix.targets.firefox.enable = false;

    programs.firefox = {
      enable = true;
    };
  };
}
