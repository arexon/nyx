{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.nyx.apps.alacritty;

  inherit (config.colorscheme) palette;

  font = "Iosevka NF";

  numux = "${pkgs.numux}/bin/numux";
in {
  options.nyx.apps.alacritty = {
    enable = mkBoolOpt false "Whether to enable Alacritty terminal emulator.";
  };

  config = mkIf cfg.enable {
    programs.alacritty = {
      enable = true;
      settings = {
        shell.program = numux;
        mouse.hide_when_typing = true;
        window.decorations = "None";
        font = {
          size = 12;
          normal.family = font;
          bold = {
            family = font;
            style = "Bold";
          };
          bold_italic = {
            family = font;
            style = "BoldItalic";
          };
          italic = {
            family = font;
            style = "Italic";
          };
        };
        colors = {
          primary.background = "#${palette.base00}";
          primary.foreground = "#${palette.base06}";
          normal = {
            black = "#${palette.base03}";
            red = "#${palette.base08}";
            green = "#${palette.base0B}";
            yellow = "#${palette.base0A}";
            blue = "#${palette.base0D}";
            magenta = "#${palette.base0E}";
            cyan = "#${palette.base0C}";
            white = "#${palette.base06}";
          };
          bright = {
            black = "#${palette.base04}";
            red = "#${palette.base08}";
            green = "#${palette.base0B}";
            yellow = "#${palette.base0A}";
            blue = "#${palette.base0D}";
            magenta = "#${palette.base0E}";
            cyan = "#${palette.base0C}";
            white = "#${palette.base07}";
          };
        };
      };
    };
  };
}
