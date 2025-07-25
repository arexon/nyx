{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.nyx.hardware.graphics;
in {
  options.nyx.hardware.graphics = {
    enable = mkBoolOpt false "Whether to enable graphics support.";
    nvidia.enable = mkBoolOpt false "Whether to enable Nvidia support.";
  };

  config =
    mkIf cfg.enable {
      hardware = {
        graphics.enable = true;
      };
    }
    // mkIf cfg.nvidia.enable {
      hardware.nvidia = {
        package = config.boot.kernelPackages.nvidiaPackages.stable;
        modesetting.enable = true;
        open = false;
        powerManagement.enable = true;
        nvidiaSettings = false;
      };
      services.xserver.videoDrivers = ["nvidia"];
    };
}
