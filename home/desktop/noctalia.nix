{
  inputs,
  config,
  system,
  user,
  ...
}: let
  inherit (config.colorscheme) palette;
in {
  imports = [
    inputs.noctalia.homeModules.default
  ];

  home.packages = [
    inputs.noctalia.packages.${system}.default
  ];

  programs.noctalia-shell = {
    enable = true;
    colors = {
      mError = "#${palette.base08}";
      mOnError = "#${palette.base00}";
      mOnPrimary = "#${palette.base00}";
      mOnSecondary = "#${palette.base00}";
      mOnSurface = "#${palette.base06}";
      mOnSurfaceVariant = "#${palette.base05}";
      mOnTertiary = "#${palette.base00}";
      mOutline = "#${palette.base03}";
      mPrimary = "#${palette.base0E}";
      mSecondary = "#${palette.base0A}";
      mShadow = "#${palette.base00}";
      mSurface = "#${palette.base00}";
      mSurfaceVariant = "#${palette.base02}";
      mTertiary = "#${palette.base0D}";
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
