{pkgs, ...}: {
  stylix = {
    cursor = {
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
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
