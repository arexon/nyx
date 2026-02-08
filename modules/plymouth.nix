{
  flake.modules.nixos.plymouth = {
    boot = {
      plymouth.enable = true;
      kernelParams = [
        "quiet"
        "splash"
        "boot.shell_on_fail"
        "rd.systemd.show_status=false"
        "rd.udev.log_level=3"
        "udev.log_priority=3"
      ];
      initrd = {
        verbose = false;
        systemd.enable = true;
      };
      consoleLogLevel = 0;
    };
  };
}
