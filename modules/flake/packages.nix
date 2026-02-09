{
  inputs,
  withSystem,
  ...
}: {
  flake-file.inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    pkgs-by-name-for-flake-parts.url = "github:drupol/pkgs-by-name-for-flake-parts";
  };

  imports = [
    inputs.pkgs-by-name-for-flake-parts.flakeModule
  ];

  perSystem = {system, ...}: {
    _module.args.pkgs = import inputs.nixpkgs {
      inherit system;
      overlays = [
        (final: _prev: {
          unstable = import inputs.nixpkgs-unstable {
            inherit (final) config;
            inherit system;
          };
        })
      ];
    };

    pkgsDirectory = ../../packages;
  };

  flake = {
    overlays.default = final: prev:
      withSystem prev.stdenv.hostPlatform.system (
        {config, ...}: {
          local = config.packages;
        }
      );
  };
}
