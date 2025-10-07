{
  inputs,
  config,
  system,
  user,
  ...
}: {
  home.packages = [
    inputs.noctalia.packages.${system}.default
  ];

  programs.noctalia-shell = {
    enable = true;
    colors = with config.lib.stylix.colors.withHashtag; {
      mError = base08;
      mOnError = base00;
      mOnPrimary = base00;
      mOnSecondary = base00;
      mOnSurface = base06;
      mOnSurfaceVariant = base05;
      mOnTertiary = base00;
      mOutline = base03;
      mPrimary = base0E;
      mSecondary = base0A;
      mShadow = base00;
      mSurface = base00;
      mSurfaceVariant = base02;
      mTertiary = base0D;
    };
    settings = {
      general = {
        avatarImage = "/home/${user}/.pfp.png";
        showScreenCorners = true;
      };
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
