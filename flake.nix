{
  inputs = {
    nixpkgs-nixos.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-colors.url = "github:misterio77/nix-colors";

    nixcord.url = "github:kaylorben/nixcord";

    helix-editor.url = "github:arexon/helix";

    nix-flatpak.url = "github:gmodena/nix-flatpak";

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    quickshell = {
      url = "github:outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.quickshell.follows = "quickshell";
    };
  };

  outputs = inputs @ {
    nixpkgs,
    home-manager,
    niri,
    noctalia,
    nixcord,
    nix-flatpak,
    ...
  }: let
    inherit (nixpkgs) lib;

    system = "x86_64-linux";
    user = "arexon";
    host = "falcon";
    email = "arexonreal@gmail.com";

    pkgs = import nixpkgs {inherit system;};
  in {
    formatter.${system} = pkgs.alejandra;

    overlays = import ./overlays {inherit inputs;};

    nixosConfigurations = {
      falcon = lib.nixosSystem {
        inherit system;
        specialArgs = {inherit inputs user host;};
        modules = [
          home-manager.nixosModules.home-manager
          niri.nixosModules.niri
          noctalia.nixosModules.default
          {
            nixpkgs = {
              config.allowUnfree = true;
              overlays = [
                (import ./overlays)
                niri.overlays.niri
              ];
            };
          }
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = {inherit system inputs user email;};
              users.${user}.imports = [
                noctalia.homeModules.default
                nixcord.homeModules.nixcord
                nix-flatpak.homeManagerModules.nix-flatpak
                ./home
              ];
            };
          }
          ./nixos
        ];
      };
    };
  };
}
