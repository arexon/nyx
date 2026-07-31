{
  flake.modules.homeManager.fonts = {pkgs, ...}: {
    stylix.targets = {
      font-packages.enable = true;
      fontconfig.enable = true;
    };

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
