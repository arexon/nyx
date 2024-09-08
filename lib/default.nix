{
  mkSystem = {
    lib,
    inputs,
    system,
    hostname,
    username,
  }: let
    getModulePaths = root: let
      entries = builtins.attrNames (builtins.readDir root);
      processEntry = entry: let
        dirPath = "${root}/${entry}";
        defaultModulePath = "${dirPath}/default.nix";
        result =
          if builtins.pathExists defaultModulePath
          then defaultModulePath
          else getModulePaths dirPath;
      in
        result;
      result = lib.lists.flatten (builtins.map (entry: processEntry entry) entries);
    in
      result;
  in
    lib.nixosSystem {
      inherit system;
      lib = lib.extend (_: lib: (import ./module {inherit lib;}));
      modules =
        [
          {
            nixpkgs = {
              config.allowUnfree = true;
              overlays = builtins.map (path: import path) (getModulePaths ../overlays);
            };
          }
          inputs.home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = {inherit system inputs;};
              users.${username}.imports = (getModulePaths ../modules/home) ++ [../users/${username}];
            };
          }
          {
            nyx.user.name = username;
            networking.hostName = hostname;
          }
          ../machines/${hostname}
        ]
        ++ (getModulePaths ../modules/nixos);
    };
}
