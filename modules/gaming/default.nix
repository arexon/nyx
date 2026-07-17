{inputs, ...}: {
  flake-file.inputs = {
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
    homebrew.casks = [
      "steam"
    ];
  };

  flake.modules.homeManager.gaming = {pkgs, ...}: {
    home.file."options.txt" = {
      source = ./options.txt;
      target = "com.mojang/minecraftpe/options.txt";
    };

    home.packages = with pkgs; [
      mangohud
      mangojuice
      pcsx2
      inputs.hytale-launcher.packages.${pkgs.stdenv.hostPlatform.system}.default
      r2modman
      protontricks
      mesa-demos
      steamcmd
    ];
  };
}
