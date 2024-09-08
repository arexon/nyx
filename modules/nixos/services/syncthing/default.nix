{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.nyx.services.syncthing;

  username = config.nyx.user.name;
in {
  options.nyx.services.syncthing = {
    enable = mkBoolOpt false "Whether to enable Syncthing for file syncing.";
  };

  config = mkIf cfg.enable {
    networking.firewall = {
      allowedTCPPorts = [8384 22000];
      allowedUDPPorts = [22000 21027];
    };

    services.syncthing = {
      enable = true;
      user = username;
      configDir = "/home/${username}/.config/syncthing";
    };
  };
}
