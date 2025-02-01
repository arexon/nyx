{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.nyx.desktop.gtk;
in {
  options.nyx.desktop.gtk = {
    enable = mkBoolOpt false "Whether to configure GTK.";
  };

  config = mkIf cfg.enable {
    gtk = {
      enable = true;
      iconTheme = {
        name = "Papirus";
        package = pkgs.papirus-icon-theme;
      };
      cursorTheme = {
        name = "Bibata-Modern-Ice";
        package = pkgs.bibata-cursors;
      };
      gtk4.extraCss = ''
        window {
          border-radius: 0;
        }
      '';
    };
  };
}
