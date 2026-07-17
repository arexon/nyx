let
  stateVersion = "26.05";
in {
  flake.modules.homeManager.core = {
    home = {inherit stateVersion;};
  };

  flake.modules.nixos.core = {
    system = {inherit stateVersion;};
  };

  flake.modules.darwin.core = {
    system.stateVersion = 7;
  };
}
