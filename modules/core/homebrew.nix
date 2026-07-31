{inputs, ...}: {
  flake-file.inputs = {
    homebrew.url = "github:zhaofengli/nix-homebrew";

    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
  };

  flake.modules.darwin.core = {
    config,
    lib,
    ...
  }: let
    inherit (lib.lists) singleton;
  in {
    imports = singleton inputs.homebrew.darwinModules.nix-homebrew;

    homebrew = {
      enable = true;
      onActivation.cleanup = "zap";
      taps = builtins.attrNames config.nix-homebrew.taps;
    };

    nix-homebrew = {
      enable = true;
      user = config.system.primaryUser;
      taps = {
        "homebrew/homebrew-core" = inputs.homebrew-core;
        "homebrew/homebrew-cask" = inputs.homebrew-cask;
      };
      mutableTaps = false;
    };
  };
}
