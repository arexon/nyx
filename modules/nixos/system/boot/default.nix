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
    boot.initrd.systemd.enable = true;
    boot.loader.systemd-boot.enable = true;
    boot.loader.systemd-boot.configurationLimit = 16;
    boot.loader.efi.canTouchEfiVariables = true;
  };
}
