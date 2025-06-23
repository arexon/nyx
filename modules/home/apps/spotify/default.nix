{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
with lib; let
  cfg = config.nyx.apps.spotify;
in {
  options.nyx.apps.spotify = {
    enable = mkBoolOpt false "Whether to enable Spotify.";
  };

  config = mkIf cfg.enable {
    home.packages = [
      (pkgs.spotify.overrideAttrs (oldAttrs: {
        postFixup = ''
          substituteInPlace $out/share/applications/spotify.desktop \
            --replace-fail "Exec=spotify %U" "Exec=env NIXOS_OZONE_WL= spotify %U"
        '';
      }))
    ];
  };
}
