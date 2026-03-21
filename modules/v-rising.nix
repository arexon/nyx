{
  flake.modules.nixos.v-rising = {
    pkgs,
    lib,
    ...
  }: let
    dataDir = "/srv/v-rising";
  in {
    users.users.vrising = {
      isSystemUser = true;
      group = "vrising";
      home = dataDir;
      createHome = true;
    };

    environment.systemPackages = with pkgs; [steamcmd];

    users.groups.vrising = {};

    networking.firewall.allowedUDPPorts = [9876 9877];

    systemd.services.vrising = {
      description = "V Rising Dedicated Server";
      after = ["network.target"];
      wantedBy = ["multi-user.target"];

      serviceConfig = {
        Type = "simple";
        User = "vrising";
        Group = "vrising";
        WorkingDirectory = "${dataDir}/default";
        ExecStart = "${lib.getExe' pkgs.xvfb-run "xvfb-run"} ${lib.getExe pkgs.wine64} start_server.bat";
        Restart = "on-failure";
        RestartSec = "10s";
        KillMode = "control-group";
        TimeoutStopSec = "30s";
        KillSignal = "SIGINT";
        FinalKillSignal = "SIGKILL";
      };

      environment = {
        WINEPREFIX = "${dataDir}/.wine";
      };
    };
  };
}
