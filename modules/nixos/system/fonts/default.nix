{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.nyx.system.fonts;
in {
  options.nyx.system.fonts = with types; {
    enable = mkBoolOpt false "Whether to manage fonts.";
    fonts = mkOpt (listOf package) [] "Custom font packages to install.";
  };

  config = mkIf cfg.enable {
    fonts.packages = with pkgs;
      [
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-cjk-serif
        noto-fonts-emoji
        nerd-fonts.iosevka
      ]
      ++ cfg.fonts;
  };
}
