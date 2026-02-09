let
  stateVersion = "25.11";
in {
  flake.modules.homeManager.core = {
    home = {inherit stateVersion;};
  };

  flake.modules.nixos.core = {
    system = {inherit stateVersion;};
  };
}
