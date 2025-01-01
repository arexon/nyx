{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.nyx.apps.ghostty;

  numux = "${pkgs.numux}/bin/numux";
in {
  options.nyx.apps.ghostty = {
    enable = mkBoolOpt false "Whether to enable Ghostty terminal emulator.";
  };

  config = mkIf cfg.enable {
    programs.ghostty = {
      enable = true;
      settings = {
        command = numux;
        mouse-hide-while-typing = "true";
        confirm-close-surface = "false";
        gtk-titlebar = "false";
        gtk-tabs-location = "bottom";
        window-padding-x = "0";
        window-padding-y = "0";
        clipboard-read = "allow";
        clipboard-write = "allow";
        copy-on-select = "false";
        theme = "Kanagawa Wave";
        font-family = "Iosevka NF";
      };
    };
  };
}
