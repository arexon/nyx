{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.nyx.apps.spotify;
in {
  options.nyx.apps.spotify = {
    enable = mkBoolOpt false "Whether to enable Spotify.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [spotify];
  };
}
