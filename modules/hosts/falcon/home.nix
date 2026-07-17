{config, ...}: {
  flake.modules.homeManager."homes/arexon@falcon" = {
    imports = with config.flake.modules.homeManager; [
      arexon
      cli
      core
      fonts
      gaming
      git
      gui
      helix
      niri
      noctalia
      shell
      stylix
      water-reminders
      wayland-env
      xdg
      zsa
    ];

    programs.niri.settings.outputs."DP-1".mode = {
      width = 3440;
      height = 1440;
      refresh = 175.000;
    };
  };
}
