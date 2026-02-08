{
  flake.modules.homeManager.xdg = {config, ...}: {
    xdg = {
      enable = true;
      userDirs = {
        enable = true;
        download = "${config.home.homeDirectory}/dl";
        videos = "${config.home.homeDirectory}/vids";
        pictures = "${config.home.homeDirectory}/pics";
        documents = "${config.home.homeDirectory}/docs";
        desktop = "${config.home.homeDirectory}/desktop";
        music = null;
        templates = null;
        publicShare = null;
      };
    };

    home.sessionVariables = {
      CARGO_HOME = "${config.xdg.dataHome}/cargo";
      GOPATH = "${config.xdg.dataHome}/go";
      NPM_CONFIG_CACHE = "${config.xdg.cacheHome}/npm";
      PYTHON_HISTORY = "${config.xdg.configHome}/python/history";
      WINEPREFIX = "${config.xdg.dataHome}/wine";
    };
  };
}
