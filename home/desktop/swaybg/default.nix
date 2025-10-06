{pkgs, ...}: let
  swaybg = "${pkgs.swaybg}/bin/swaybg";

  wallpaper = builtins.path {path = ./platform.jpg;};
in {
  systemd.user.services.swaybg = {
    Unit = {
      PartOf = ["graphical-session.target"];
      After = ["graphical-session-pre.target"];
    };
    Service = {
      Type = "simple";
      ExecStart = "${swaybg} -m fill -i ${wallpaper}";
      Restart = "on-failure";
      RestartSec = 1;
    };
    Install.WantedBy = ["graphical-session.target"];
  };
}
