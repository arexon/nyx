{inputs, ...}: let
  theme = pkgs: "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
in {
  flake-file.inputs = {
    stylix = {
      url = "github:nix-community/stylix";
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

  flake.modules.darwin.stylix = {pkgs, ...}: {
    imports = [inputs.stylix.darwinModules.stylix];
    stylix = {
      enable = true;
      base16Scheme = theme pkgs;
    };
  };

  flake.modules.homeManager.stylix = {
    lib,
    pkgs,
    config,
    ...
  }: {
    stylix =
      {
        cursor = {
          name = "catppuccin-mocha-dark-cursors";
          package = pkgs.catppuccin-cursors.mochaDark;
          size = 24;
        };
        fonts = {
          sansSerif.name = "Lexend";
          serif.name = config.stylix.fonts.sansSerif.name;
          monospace.name = "Iosevka NF";
          emoji.name = "Noto Color Emoji";
        };
      }
      // lib.optionalAttrs pkgs.stdenv.hostPlatform.isLinux {
        icons = {
          enable = true;
          dark = "Papirus";
          package = pkgs.papirus-icon-theme;
        };
      };
  };
}
