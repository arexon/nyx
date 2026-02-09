{
  inputs,
  lib,
  config,
  withSystem,
  ...
}: let
  hostsPrefix = "hosts/";
  homesPrefix = "homes/";
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
          {networking = {inherit hostName;};}
        ];
      };
    });

  flake.homeConfigurations =
    config.flake.modules.homeManager
    |> lib.filterAttrs (data: _: lib.hasPrefix homesPrefix data)
    |> lib.mapAttrs' (data: module: let
      parts =
        data
        |> lib.removePrefix homesPrefix
        |> lib.splitStringBy (_: curr: lib.elem curr ["@" ":"]) false;
      user = lib.elemAt parts 0;
      host = lib.elemAt parts 1;
      system = lib.elemAt parts 2;
    in {
      name = "${user}@${host}";
      value = withSystem system (
        {pkgs, ...}:
          inputs.home-manager.lib.homeManagerConfiguration {
            inherit pkgs;
            extraSpecialArgs = {inherit inputs;};
            modules = [
              module
              {
                home = {
                  username = user;
                  homeDirectory = "/home/${user}";
                };
              }
            ];
          }
      );
    });
}
