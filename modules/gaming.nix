{inputs, ...}: {
  flake-file.inputs = {
    hytale-launcher = {
      url = "github:JPyke3/hytale-launcher-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    proton-cachyos.url = "github:powerofthe69/proton-cachyos-nix";
  };

  flake.modules.nixos.gaming = {pkgs, ...}: {
    nixpkgs.overlays = [inputs.proton-cachyos.overlays.default];

    programs.steam = {
      enable = true;
      extraCompatPackages = with pkgs; [
        proton-cachyos
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
      r2modman
      protontricks
    ];

    programs.niri.settings = {
      window-rules = [
        {
          matches = [{app-id = "steam";}];
          open-on-workspace = "IV";
        }
      ];
    };
  };
}
