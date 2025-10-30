{pkgs, ...}: {
  stylix = {
    cursor = {
      name = "catppuccin-macchiato-blue-cursors";
      package = pkgs.catppuccin-cursors.macchiatoBlue;
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
