{
  inputs,
  config,
  system,
  user,
  lib,
  ...
}: let
  plugins-source-url = "https://github.com/noctalia-dev/noctalia-plugins";
in {
  home.packages = [
    inputs.noctalia.packages.${system}.default
  ];

  programs.noctalia-shell = {
    enable = true;
    colors = lib.mkForce (with config.lib.stylix.colors.withHashtag; {
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
    });
    plugins.states = {
      screen-recorder = {
        enabled = true;
        sourceUrl = plugins-source-url;
      };
      catwalk = {
        enabled = true;
        sourceUrl = plugins-source-url;
      };
    };
    pluginSettings = {
      screen-recorder = {
        directory = config.xdg.userDirs.videos;
        audioCodec = "aac";
        colorRange = "full";
      };
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
          center = [{id = "Clock";}];
          right = [
            {
              id = "Tray";
              blacklist = ["bluetooth*"];
              drawerEnabled = false;
            }
            {
              id = "CustomButton";
              icon = "app-window";
              leftClickExec = "nu -e 'niri msg action set-dynamic-cast-window --id (niri msg --json pick-window | from json | get id)'";
            }
            {id = "plugin:screen-recorder";}
            {id = "NotificationHistory";}
            {id = "Bluetooth";}
            {id = "Microphone";}
            {id = "Volume";}
            {id = "plugin:catwalk";}
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
          enabled = false;
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
      notifications.location = "bottom";
      osd = {
        alwaysOnTop = true;
        location = "bottom";
        settingsPanelAttachToBar = true;
      };
      wallpaper = {
        directory = "${config.xdg.userDirs.pictures}/walls";
        randomEnabled = true;
        randomIntervalSec = 60 * 60;
      };
      location.name = "Cairo";
      dock.enabled = false;
      audio.visualizerType = "none";
      setupCompleted = true;
    };
  };
}
