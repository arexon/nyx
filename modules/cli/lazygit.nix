{
  flake.modules.homeManager.cli = {
    stylix.targets.lazygit.enable = true;

    programs.lazygit = {
      enable = true;
      settings = {
        gui = {
          skipDiscardChangeWarning = true;
          showCommandLog = false;
        };
        git.overrideGpg = true;
      };
    };
  };
}
