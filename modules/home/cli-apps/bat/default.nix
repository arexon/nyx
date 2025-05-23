{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.nyx.cli-apps.bat;
in {
  options.nyx.cli-apps.bat = {
    enable = mkBoolOpt false "Whether to enable bat.";
  };

  config = mkIf cfg.enable {
    programs.bat = {
      enable = true;
      config = {
        theme = "kanagawa";
        style = "plain";
      };
      themes = {
        kanagawa = {
          src = pkgs.fetchFromGitHub {
            owner = "obergodmar";
            repo = "kanagawa-tmTheme";
            rev = "6a8f523f2f6f64f8e362f4ee59c0b610a1a3d2f7";
            sha256 = "sha256-FdIqdAtHfx5VElBK3WKULn2GTvZh2evfFLSEdQFqbpo=";
          };
          file = "Kanagawa.tmTheme";
        };
      };
    };
  };
}
