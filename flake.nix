{
  inputs = {
    nixpkgs-25-05.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixcord.url = "github:kaylorben/nixcord";

    helix-editor.url = "github:devmanuelli/helix/textDocument/inlineCompletion";

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hytale-launcher = {
      url = "github:TNAZEP/HytaleLauncherFlake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel";
  };

  outputs = inputs @ {
    nixpkgs,
    home-manager,
    niri,
    noctalia,
    nixcord,
    stylix,
    spicetify,
    helix-editor,
    nix-cachyos-kernel,
    ...
  }: let
    inherit (nixpkgs) lib;

    system = "x86_64-linux";
    user = "arexon";
    host = "falcon";
    email = "me@arexon.dev";

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
        specialArgs = {inherit inputs user host;};
        modules = [
          home-manager.nixosModules.home-manager
          niri.nixosModules.niri
          noctalia.nixosModules.default
          stylix.nixosModules.stylix
          {
            nixpkgs = {
              config.allowUnfree = true;
              hostPlatform = {inherit system;};
              overlays = [
                (import ./overlays {inherit inputs;})
                niri.overlays.niri
                helix-editor.overlays.helix
                nix-cachyos-kernel.overlays.pinned
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
