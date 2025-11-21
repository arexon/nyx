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
        dimmerOpacity = 0;
        enableShadows = false;
      };
      bar = {
        density = "comfortable";
        widgets = {
          left = [
            {
              id = "Workspace";
              labelMode = "none";
            }
            {
              id = "MediaMini";
              showAlbumArt = true;
              maxWidth = 200;
            }
            {
              id = "ActiveWindow";
              hideMode = "visible";
              maxWidth = 200;
            }
          ];
          center = [
            {id = "Clock";}
          ];
          right = [
            {
              id = "Tray";
              blacklist = ["bluetooth*"];
              drawerEnabled = false;
            }
            {id = "ScreenRecorder";}
            {id = "NotificationHistory";}
            {id = "Bluetooth";}
            {id = "Microphone";}
            {id = "Volume";}
          ];
        };
      };
      appLauncher = {
        enableClipboardHistory = true;
        position = "follow_bar";
      };
      controlCenter.cards = [
        {
          id = "profile-card";
          enabled = true;
        }
        {
          id = "media-sysmon-card";
          enabled = true;
        }
        {
          id = "audio-card";
          enabled = true;
        }
        {
          id = "weather-card";
          enabled = false;
        }
        {
          id = "shortcuts-card";
          enabled = false;
        }
      ];
      notifications = {
        location = "bottom";
        alwaysOnTop = true;
      };
      screenRecorder = {
        directory = config.xdg.userDirs.videos;
        audioCodec = "aac";
        colorRange = "full";
      };
      osd = {
        alwaysOnTop = true;
        location = "bottom";
        settingsPanelAttachToBar = true;
      };
      wallpaper = {
        monitors = [
          {
            name = "DP-1";
            wallpaper = ./laundry.jpg;
          }
        ];
      };
      location.name = "Cairo";
      dock.enabled = false;
      audio.visualizerType = "none";
      setupCompleted = true;
    };
  };
}
