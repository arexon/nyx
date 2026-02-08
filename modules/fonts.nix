{
  flake.modules.homeManager.fonts = {pkgs, ...}: {
    home.packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-color-emoji
      nerd-fonts.iosevka
      lexend
    ];
  };
}
