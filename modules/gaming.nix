{inputs, ...}: {
  flake-file.inputs = {
    hytale-launcher = {
      url = "github:JPyke3/hytale-launcher-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  flake.modules.nixos.gaming = {pkgs, ...}: {
    programs.steam = {
      enable = true;
      extraCompatPackages = with pkgs; [
        proton-ge-bin
        local.proton-gdk-bin
      ];
    };
  };

  flake.modules.homeManager.gaming = {pkgs, ...}: {
    home.packages = with pkgs; [
      mangohud
      prismlauncher
      pcsx2
      inputs.hytale-launcher.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
  };
}
