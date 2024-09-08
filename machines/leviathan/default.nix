{
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
      flatpak.enable = true;
      syncthing.enable = true;
    };
    desktop = {
      gnome.enable = true;
    };
    apps = {
      steam.enable = true;
    };
  };

  system.stateVersion = "24.05";
}
