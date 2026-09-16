{inputs, ...}: {
  flake-file.inputs = {
    mac-app-util = {
      url = "github:hraban/mac-app-util";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  flake.modules.homeManager.mac-app-util.imports = [
    inputs.mac-app-util.homeManagerModules.default
  ];
}
