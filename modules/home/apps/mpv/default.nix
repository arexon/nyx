{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.nyx.apps.mpv;
in {
  options.nyx.apps.mpv = {
    enable = mkBoolOpt false "Whether to enable mpv.";
  };

  config = mkIf cfg.enable {
    programs.mpv = {
      enable = true;
    };
  };
}
