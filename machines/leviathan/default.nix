{
  imports = [./hardware.nix];

  # This is disabled due to `HibernateLocation` not being removed after waking
  # up from hibernation. I couldn't find any fix for it so it'll stay like this
  # for now. See:
  #
  # <https://github.com/systemd/systemd/pull/32043>
  # <https://github.com/systemd/systemd/blob/08491c0cdf7834c45b910e604a8e7116178284cb/src/hibernate-resume/hibernate-resume-config.c#L143>
  systemd.services."systemd-hibernate-clear".enable = false;

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
      graphics.nvidia.enable = true;
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

  system.stateVersion = "24.05";
}
