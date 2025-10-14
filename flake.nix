{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-25.url = "nixpkgs/nixos-25.05";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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
      url = "github:noctalia-dev/noctalia-shell?ref=v2.17.3";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.quickshell.follows = "quickshell";
    };

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    elephant = {
      url = "github:abenz1267/elephant";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    walker = {
      url = "github:abenz1267/walker";
      inputs = {
        elephant.follows = "elephant";
        nixpkgs.follows = "nixpkgs";
      };
    };
  };

  outputs = inputs @ {
    nixpkgs,
    home-manager,
    niri,
    noctalia,
    nixcord,
    nix-flatpak,
    stylix,
    spicetify,
    walker,
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

    devShells.${system}.default = pkgs.mkShell {
      packages = with pkgs; [
        stylua
        lua-language-server
      ];
    };

    nixosConfigurations = {
      falcon = lib.nixosSystem {
        inherit system;
        specialArgs = {inherit inputs user host;};
        modules = [
          home-manager.nixosModules.home-manager
          niri.nixosModules.niri
          noctalia.nixosModules.default
          stylix.nixosModules.stylix
          {
            nixpkgs = {
              config.allowUnfree = true;
              overlays = [
                (import ./overlays {inherit inputs system;})
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
                spicetify.homeManagerModules.spicetify
                walker.homeManagerModules.default
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
