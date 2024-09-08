{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.nyx.system.plymouth;
in {
  options.nyx.system.plymouth = {
    enable = mkBoolOpt false "Whether to enable plymouth.";
  };

  config = mkIf cfg.enable {
    boot = {
      plymouth = {
        enable = true;
        theme = "catppuccin-macchiato";
        themePackages = with pkgs; [
          catppuccin-plymouth
        ];
      };

      consoleLogLevel = 0;
      initrd.verbose = false;
      kernelParams = [
        "quiet"
        "splash"
        "boot.shell_on_fail"
        "rd.systemd.show_status=false"
        "rd.udev.log_level=3"
        "udev.log_priority=3"
      ];
      loader.timeout = 0;
    };
  };
}
