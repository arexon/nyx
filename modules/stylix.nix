{inputs, ...}: let
  theme = pkgs: "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
in {
  flake-file.inputs = {
    stylix = {
      url = "github:nix-community/stylix/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  flake.modules.nixos.stylix = {pkgs, ...}: {
    imports = [inputs.stylix.nixosModules.stylix];

    stylix = {
      enable = true;
      base16Scheme = theme pkgs;
    };
  };

  flake.modules.homeManager.stylix = {
    pkgs,
    config,
    ...
  }: {
    imports = [inputs.stylix.homeModules.stylix];

    stylix = {
      enable = true;
      base16Scheme = theme pkgs;
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
      fonts = {
        sansSerif.name = "Lexend";
        serif.name = config.stylix.fonts.sansSerif.name;
        monospace.name = "Iosevka NF";
        emoji.name = "Noto Color Emoji";
      };
    };
  };
}
