{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-25.url = "github:NixOS/nixpkgs/nixos-25.05";

    chaotic-nyx.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixcord.url = "github:kaylorben/nixcord";

    helix-editor.url = "github:helix-editor/helix";

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

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    nixpkgs,
    home-manager,
    niri,
    noctalia,
    nixcord,
    stylix,
    spicetify,
    chaotic-nyx,
    helix-editor,
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
          chaotic-nyx.nixosModules.default
          {
            nixpkgs = {
              config.allowUnfree = true;
              overlays = [
                (import ./overlays {inherit inputs;})
                niri.overlays.niri
                helix-editor.overlays.helix
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
                spicetify.homeManagerModules.spicetify
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
