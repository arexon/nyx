{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.nyx.apps.firefox;
in {
  options.nyx.apps.firefox = {
    enable = mkBoolOpt false "Whether to enable Firefox.";
  };

  config = mkIf cfg.enable {
    programs.firefox = {
      enable = true;
    };
  };
}
