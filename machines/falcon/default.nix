{pkgs, ...}: {
  imports = [./hardware.nix];

  nyx = {
    nix.enable = true;
    system = {
      boot.enable = true;
      time.enable = true;
      fonts.enable = true;
      plymouth.enable = true;
    };
    hardware = {
      audio.enable = true;
      graphics.enable = true;
      storage.enable = true;
    };
    services = {
      ssh.enable = true;
      syncthing.enable = true;
      kanata.enable = true;
    };
    desktop = {
      gnome.enable = true;
    };
    apps = {
      steam.enable = true;
    };
  };

  # TODO: Maybe configure with a wayland option.
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Temporary until network cards on x870 motherboards are fixed in the kernel.
  boot.kernelPackages = pkgs.linuxPackages_6_14;

  system.stateVersion = "25.05";
}
