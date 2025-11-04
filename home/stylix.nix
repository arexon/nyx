{pkgs, ...}: {
  stylix = {
    cursor = {
      name = "catppuccin-mocha-dark-cursors";
      package = pkgs.catppuccin-cursors.mochaDark;
      size = 24;
    };
    icons = {
      enable = true;
      dark = "Papirus";
      package = pkgs.papirus-icon-theme;
    };
    fonts.monospace.name = "Iosevka NF";
  };
}
