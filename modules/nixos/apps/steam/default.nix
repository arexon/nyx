{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.nyx.apps.steam;
in {
  options.nyx.apps.steam = {
    enable = mkBoolOpt false "Whether to enable Steam.";
  };

  config = mkIf cfg.enable {
    programs.steam = {
      enable = true;
    };
  };
}
