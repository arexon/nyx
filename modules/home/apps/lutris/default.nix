{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.nyx.games.lutris;
in {
  options.nyx.games.lutris = {
    enable = mkBoolOpt false "Whether to enable Lutris.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [lutris wine];
  };
}
