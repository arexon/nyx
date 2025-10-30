{pkgs, ...}: {
  stylix = {
    cursor = {
      name = "catppuccin-macchiato-dark-cursors";
      package = pkgs.catppuccin-cursors.macchiatoDark;
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
