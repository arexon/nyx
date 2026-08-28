{
  flake.modules.homeManager.xdg = {
    config,
    lib,
    pkgs,
    ...
  }: let
    inherit (pkgs.stdenv.hostPlatform) isLinux;
  in {
    xdg = {
      enable = isLinux;
      userDirs = lib.mkIf isLinux {
        enable = true;
        setSessionVariables = true;
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
