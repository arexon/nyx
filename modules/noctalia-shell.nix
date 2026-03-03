{inputs, ...}: {
  flake-file.inputs = {
    noctalia-shell = {
      url = "github:noctalia-dev/noctalia-shell/v4.6.1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  flake.modules.homeManager.noctalia = {
    config,
    lib,
    pkgs,
    ...
  }: let
    noctalia-reload =
      pkgs.writers.writeFishBin "noctalia-reload"
      ''
        ${lib.getExe pkgs.killall} .quickshell-wra; or true
        noctalia-shell
      '';

    set-niri-dynamic-cast-window =
      pkgs.writers.writeFishBin "set-niri-dynamic-cast-window"
      ''
        niri msg action set-dynamic-cast-window --id (niri msg --json pick-window | ${lib.getExe pkgs.killall} -r '.id')
      '';
  in {
    imports = [
      inputs.noctalia-shell.homeModules.default
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
      settings = {
        general = {
          avatarImage = "${config.home.homeDirectory}/.pfp.png";
          showScreenCorners = true;
          dimmerOpacity = 0;
          enableShadows = false;
        };
        bar = {
          density = "comfortable";
          position = "left";
          capsuleOpacity = lib.mkForce 0.25;
          capsuleColorKey = "primary";
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
                leftClickExec = lib.getExe set-niri-dynamic-cast-window;
              }
              {id = "NotificationHistory";}
              {id = "Bluetooth";}
              {id = "Microphone";}
              {id = "Volume";}
            ];
          };
        };
        appLauncher = {
          viewMode = "grid";
          density = "compact";
          position = "follow_bar";
          enableClipboardHistory = true;
          showCategories = false;
          enableSettingsSearch = false;
          enableWindowsSearch = false;
          enableSessionSearch = false;
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
        sessionMenu.showKeybinds = false;
        setupCompleted = true;
      };
    };

    programs.niri.settings = {
      spawn-at-startup = [
        {command = ["noctalia-shell"];}
      ];

      binds = with config.lib.niri.actions; let
        noctalia = cmd:
          ["noctalia-shell" "ipc" "call"]
          ++ (lib.splitString " " cmd);
      in {
        "Mod+R".action = spawn [(lib.getExe noctalia-reload)];
        "Mod+Space".action = spawn (noctalia "launcher toggle");
        "Mod+Shift+V".action = spawn (noctalia "launcher clipboard");
        "Mod+Shift+Z".action = spawn (noctalia "notifications toggleHistory");
        "Mod+Shift+M".action = spawn (noctalia "volume muteInput");
        "Mod+Shift+Escape".action = spawn (noctalia "sessionMenu toggle");
        "XF86AudioRaiseVolume".action = spawn (noctalia "volume increase");
        "XF86AudioLowerVolume".action = spawn (noctalia "volume decrease");
        "XF86AudioMute".action = spawn (noctalia "volume muteOutput");
      };
    };
  };
}
