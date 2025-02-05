{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.nyx.apps.lutris;
in {
  options.nyx.apps.lutris = {
    enable = mkBoolOpt false "Whether to enable Lutris.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [lutris wine];
  };
}
