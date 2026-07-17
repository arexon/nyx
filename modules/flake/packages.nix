{
  inputs,
  withSystem,
  lib,
  ...
}: {
  flake-file.inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    pkgs-by-name-for-flake-parts.url = "github:drupol/pkgs-by-name-for-flake-parts";
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  imports = [
    inputs.pkgs-by-name-for-flake-parts.flakeModule
  ];

  perSystem = {
    pkgsDirectory = ../../packages;
  };

  flake = {
    overlays.default = final: prev: let
      system = prev.stdenv.hostPlatform.system;
      supported = [
        "x86_64-linux"
        "aarch64-darwin"
      ];
    in
      if lib.elem system supported
      then
        withSystem system (
          {config, ...}:
            lib.filterAttrs (name: _: !(lib.hasPrefix "write-" name)) config.packages
        )
      else {};
  };
}
