{inputs, ...}: {
  flake-file.inputs = {
    homebrew-notproton = {
      url = "github:NotProtonNot/homebrew-notproton";
      flake = false;
    };
    hytale-launcher = {
      url = "github:JPyke3/hytale-launcher-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    proton-cachyos = {
      url = "github:powerofthe69/proton-cachyos-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  flake.modules.nixos.gaming = {pkgs, ...}: {
    nixpkgs.overlays = [inputs.proton-cachyos.overlays.default];

    programs.steam = {
      enable = true;
      extraCompatPackages = with pkgs; [
        proton-cachyos
        proton-gdk-bin
      ];
    };
  };

  flake.modules.darwin.gaming = {
    nix-homebrew.taps."NotProtonNot/homebrew-notproton" = inputs.homebrew-notproton;

    homebrew.casks = [
      "steam"
      "notprotonnot/notproton/notproton"
      "modrinth"
      "hytale"
    ];
  };

  flake.modules.homeManager.gaming = {
    lib,
    pkgs,
    ...
  }: let
    inherit (pkgs.stdenv.hostPlatform) isLinux isDarwin system;
  in {
    config = lib.mkMerge [
      (lib.mkIf isDarwin {
        home.packages = with pkgs; [
          levilauncher
        ];
      })
      (lib.mkIf isLinux {
        stylix.targets.mangohud.enable = true;

        home.file."options.txt" = {
          source = ./options.txt;
          target = "com.mojang/minecraftpe/options.txt";
        };

        home.packages = with pkgs; [
          mangohud
          mangojuice
          pcsx2
          inputs.hytale-launcher.packages.${system}.default
          r2modman
          protontricks
          mesa-demos
          steamcmd
        ];
      })
    ];
  };
}
