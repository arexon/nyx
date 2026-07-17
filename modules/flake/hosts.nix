{
  inputs,
  lib,
  config,
  ...
}: let
  hostsPrefix = "hosts/";
  homesPrefix = "homes/";

  homes =
    config.flake.modules.homeManager
    |> lib.filterAttrs (name: _: lib.hasPrefix homesPrefix name)
    |> lib.mapAttrsToList (name: module: let
      parts =
        name
        |> lib.removePrefix homesPrefix
        |> lib.splitString "@";
    in {
      user = lib.elemAt parts 0;
      host = lib.elemAt parts 1;
      inherit module;
    });

  homesFor = hostName:
    homes
    |> lib.filter (h: h.host == hostName)
    |> map (h: {
      name = h.user;
      value = h.module;
    })
    |> lib.listToAttrs;

  homeManagerDefaults = hostName: {
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      extraSpecialArgs = {inherit inputs;};
      users = homesFor hostName;
    };
  };
in {
  flake.nixosConfigurations =
    config.flake.modules.nixos
    |> lib.filterAttrs (name: _: lib.hasPrefix hostsPrefix name)
    |> lib.mapAttrs' (name: module: let
      hostName = lib.removePrefix hostsPrefix name;
    in {
      name = hostName;
      value = inputs.nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          module
          inputs.home-manager.nixosModules.home-manager
          {networking = {inherit hostName;};}
          (homeManagerDefaults hostName)
        ];
      };
    });

  flake.darwinConfigurations =
    config.flake.modules.darwin
    |> lib.filterAttrs (name: _: lib.hasPrefix hostsPrefix name)
    |> lib.mapAttrs' (name: module: let
      hostName = lib.removePrefix hostsPrefix name;
    in {
      name = hostName;
      value = inputs.nix-darwin.lib.darwinSystem {
        specialArgs = {inherit inputs;};
        modules = [
          module
          inputs.home-manager.darwinModules.home-manager
          {networking = {inherit hostName;};}
          (homeManagerDefaults hostName)
        ];
      };
    });
}
