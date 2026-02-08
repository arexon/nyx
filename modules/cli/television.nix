{
  flake.modules.homeManager.cli = {
    programs = {
      television = {
        enable = true;
        enableFishIntegration = true;
      };
      nix-search-tv = {
        enable = true;
        enableTelevisionIntegration = true;
      };
    };
  };
}
