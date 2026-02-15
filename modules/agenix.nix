{inputs, ...}: {
  flake-file.inputs = {
    agenix = {
      url = "github:ryantm/agenix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };
  };

  flake.modules.nixos.agenix = {pkgs, ...}: {
    imports = [inputs.agenix.nixosModules.default];

    nixpkgs.overlays = [inputs.agenix.overlays.default];

    environment.systemPackages = with pkgs; [
      agenix
    ];

    age.secrets = {
      restic-password.file = ../secrets/restic-password.age;
      restic-r2-environment.file = ../secrets/restic-r2-environment.age;
    };
  };
}
