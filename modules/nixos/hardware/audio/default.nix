{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.nyx.hardware.audio;
in {
  options.nyx.hardware.audio = {
    enable = mkBoolOpt false "Whether to enable audio support.";
  };

  config = mkIf cfg.enable {
    security.rtkit.enable = true;

    services.pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
      jack.enable = true;
    };

    hardware.pulseaudio.enable = false;
  };
}
