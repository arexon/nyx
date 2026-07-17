{
  flake.modules.darwin.core = {
    homebrew = {
      enable = true;
      onActivation.cleanup = "zap";
    };
  };
}
