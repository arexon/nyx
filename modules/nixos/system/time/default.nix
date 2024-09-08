{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.nyx.system.time;
in {
  options.nyx.system.time = {
    enable = mkBoolOpt false "Whether to configure timezone info.";
  };

  config = mkIf cfg.enable {
    time.timeZone = "Africa/Cairo";
  };
}
