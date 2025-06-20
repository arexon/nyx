{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.nyx.apps.mpv;
in {
  options.nyx.apps.mpv = {
    enable = mkBoolOpt false "Whether to enable mpv.";
  };

  config = mkIf cfg.enable {
    programs.mpv = {
      enable = true;
      config = {
        gpu-api = "opengl";
        screenshot-directory = "~/Pictures/mpv-screenshots";
        screenshot-format = "png";
      };
    };

    # Apparently video thumbnails require this..
    home.packages = with pkgs; [totem];
    xdg.desktopEntries."org.gnome.Totem" = {
      name = "";
      noDisplay = true;
    };
  };
}
