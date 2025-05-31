{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.nyx.desktop.gnome;
in {
  options.nyx.desktop.gnome = {
    enable = mkBoolOpt false "Whether to enable GNOME desktop.";
  };

  config = mkIf cfg.enable {
    services = {
      xserver = {
        enable = true;
        excludePackages = [pkgs.xterm];
      };
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
      # No bloat :3
      gnome.core-apps.enable = false;
      power-profiles-daemon.enable = false;
    };

    environment.gnome.excludePackages = [pkgs.gnome-tour];

    programs.dconf.enable = true;
  };
}
