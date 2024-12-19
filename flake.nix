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

    # My own private fork of https://github.com/rareitems/gadacz with support for Nix.
    gadacz.url = "git+ssh://git@github.com/arexon/gadacz";

    helix-editor.url = "github:helix-editor/helix";
  };

  outputs = inputs @ {nixpkgs, ...}: let
    system = "x86_64-linux";

    inherit (nixpkgs) lib;
    inherit (import ./lib) mkSystem;

    pkgs = import nixpkgs {inherit system;};
  in {
    formatter.${system} = pkgs.alejandra;

    nixosConfigurations = {
      leviathan = mkSystem {
        inherit system inputs lib;
        hostname = "leviathan";
        username = "arexon";
      };
    };
  };
}
