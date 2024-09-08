{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.nyx.system.boot;
in {
  options.nyx.system.boot = {
    enable = mkBoolOpt false "Whether to enable booting.";
  };

  config = mkIf cfg.enable {
    boot = {
      initrd.systemd.enable = true;
      loader = {
        systemd-boot = {
          enable = true;
          configurationLimit = 16;
        };
        efi.canTouchEfiVariables = true;
      };
    };
  };
}
