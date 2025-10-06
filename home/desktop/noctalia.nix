{
  inputs,
  config,
  system,
  user,
  ...
}: {
  imports = [
    inputs.noctalia.homeModules.default
  ];

  home.packages = [
    inputs.noctalia.packages.${system}.default
  ];

  programs.noctalia-shell = {
    enable = true;
    settings = {
      general = {
        avatarImage = "/home/${user}/.pfp.png";
        showScreenCorners = true;
      };
      colorSchemes.predefinedScheme = "Kanagawa";
      bar = {
        density = "comfortable";
        widgets = {
          left = [
            {id = "ScreenRecorder";}
            {id = "ActiveWindow";}
            {id = "MediaMini";}
          ];
          right = [
            {id = "Tray";}
            {id = "Bluetooth";}
            {id = "Volume";}
            {id = "NotificationHistory";}
            {id = "Clock";}
            {id = "ControlCenter";}
          ];
        };
      };
      appLauncher.enableClipboardHistory = true;
      notifications.location = "bottom_right";
      screenRecorder = {
        directory = config.xdg.userDirs.videos;
        audioCodec = "aac";
        colorRange = "full";
      };
      location.name = "Cairo";
      wallpaper.enable = false;
    };
  };
}
