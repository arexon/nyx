{
  flake.modules.homeManager.water-reminders = {
    lib,
    pkgs,
    ...
  }: let
    hour = {
      start = 10;
      end = 23;
    };
    cups = 8;

    times =
      lib.genList (
        i: let
          totalMins = (hour.start * 60) + (i * ((hour.end - hour.start) / (cups - 1)) * 60);
          hr = totalMins / 60;
          min = lib.fixedWidthNumber 2 (lib.mod totalMins 60);
        in "${toString hr}:${min}"
      )
      cups;
  in {
    systemd.user.services.water-reminder = {
      Unit.Description = "Water reminder";
      Service = {
        Type = "oneshot";
        ExecStart = "${lib.getExe' pkgs.libnotify "notify-send"} '💧 Drink water' 'Stay hydrated :3'";
      };
    };

    systemd.user.timers.water-reminder = {
      Unit.Description = "Water reminder timer";
      Timer = {
        OnCalendar = times |> map (time: "*-*-* ${time}:00");
        Persistent = true;
      };
      Install.WantedBy = ["timers.target"];
    };
  };
}
