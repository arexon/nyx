{
  flake.modules.homeManager.cli = {
    stylix.targets.bat.enable = true;

    programs.bat = {
      enable = true;
      config.style = "plain";
    };
  };
}
