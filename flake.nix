# DO-NOT-EDIT. This file was auto-generated using github:vic/flake-file.
# Use `nix run .#write-flake` to regenerate it.
{
  outputs = inputs: inputs.flake-parts.lib.mkFlake {inherit inputs;} (inputs.import-tree ./modules);

  inputs = {
    agenix = {
      inputs = {
        home-manager.follows = "home-manager";
        nixpkgs.follows = "nixpkgs";
      };
      url = "github:ryantm/agenix";
    };
    disko = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/disko";
    };
    flake-file.url = "github:vic/flake-file";
    flake-parts = {
      inputs.nixpkgs-lib.follows = "nixpkgs-lib";
      url = "github:hercules-ci/flake-parts";
    };
    helix.url = "github:helix-editor/helix";
    home-manager = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/home-manager/release-25.11";
    };
    hytale-launcher = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:JPyke3/hytale-launcher-nix";
    };
    hytale-server = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:essegd/hytale-server-flake";
    };
    import-tree.url = "github:vic/import-tree";
    niri = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:sodiboo/niri-flake";
    };
    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel";
    nixcord = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:FlameFlag/nixcord";
    };
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-lib.follows = "nixpkgs";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    noctalia-shell = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:noctalia-dev/noctalia-shell/v4.5.0";
    };
    pkgs-by-name-for-flake-parts.url = "github:drupol/pkgs-by-name-for-flake-parts";
    spicetify = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:Gerg-L/spicetify-nix";
    };
    stylix = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/stylix/release-25.11";
    };
    systems.url = "github:nix-systems/default";
  };
}
