{
  inputs = {
    nixpkgs-nixos.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-colors.url = "github:misterio77/nix-colors";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    ...
  }: let
    system = "x86_64-linux";

    lib = nixpkgs.lib;
    inherit (import ./lib) mkSystem;

    pkgs = import nixpkgs {inherit system;};
  in {
    formatter.${system} = pkgs.alejandra;

    devShells.${system}.default = pkgs.mkShell {
      nativeBuildInputs = with pkgs; [nil alejandra];
    };

    nixosConfigurations = {
      leviathan = mkSystem {
        inherit system inputs lib;
        hostname = "leviathan";
        username = "arexon";
      };
    };
  };
}
