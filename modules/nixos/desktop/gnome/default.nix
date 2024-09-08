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
        displayManager.gdm.enable = true;
        desktopManager.gnome.enable = true;
        excludePackages = [pkgs.xterm];
      };
      # No bloat :3
      gnome.core-utilities.enable = false;
    };

    environment = {
      gnome.excludePackages = [pkgs.gnome-tour];
      systemPackages = with pkgs; [
        file-roller
        loupe
        nautilus
        papers
        totem
        gnome-text-editor
        gnome-weather
      ];
    };

    programs.dconf.enable = true;
  };
}
