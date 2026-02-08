{
  flake.modules.homeManager.cli = {
    programs.bat = {
      enable = true;
      config.style = "plain";
    };
  };
}
