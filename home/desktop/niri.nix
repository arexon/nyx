{
  pkgs,
  config,
  lib,
  ...
}: let
  workspaces = ["I" "II" "III" "IV" "V"];

  noctalia = cmd:
    ["noctalia-shell" "ipc" "call"]
    ++ (lib.splitString " " cmd);
in {
  programs.niri.settings = {
    outputs."DP-1".mode = {
      width = 3440;
      height = 1440;
      refresh = 175.000;
    };

    binds = with config.lib.niri.actions;
      {
        "Mod+A".action = toggle-overview;
        "Mod+Return".action = spawn "wezterm";
        "Mod+W".action = spawn "firefox";
        "Mod+E".action = spawn "nautilus";
        "Mod+V".action = spawn "pavucontrol";
        "Mod+Q".action = close-window;
        "Mod+F".action = maximize-column;
        "Mod+Shift+F".action = fullscreen-window;
        "Mod+H".action = focus-column-left;
        "Mod+L".action = focus-column-right;
        "Mod+K".action = focus-window-up;
        "Mod+J".action = focus-window-down;
        "Mod+Shift+H".action = move-column-left;
        "Mod+Shift+L".action = move-column-right;
        "Mod+Shift+K".action = expel-window-from-column;
        "Mod+Shift+J".action = consume-window-into-column;
        "Mod+Control+J".action = move-column-to-workspace-down;
        "Mod+Control+K".action = move-column-to-workspace-up;
        "Mod+Z".action = toggle-window-floating;
        "Mod+Tab".action = focus-column-right-or-first;
        "Mod+Shift+Tab".action = focus-column-left-or-last;
        "Mod+Equal".action = set-column-width "+10%";
        "Mod+Minus".action = set-column-width "-10%";
        "Mod+Shift+Equal".action = set-window-height "+10%";
        "Mod+Shift+Minus".action = set-window-height "-10%";
        "Mod+Shift+S".action = screenshot;
        # TODO: Swap to an option once added to the niri-flake.
        "Mod+F12".action.screenshot-screen = [];
        "Mod+Space".action = spawn (noctalia "launcher toggle");
        "Mod+Shift+V".action = spawn (noctalia "launcher clipboard");
        "Mod+Shift+N".action = spawn ["playerctl" "next"];
        "Mod+Shift+P".action = spawn ["playerctl" "previous"];
        "Mod+Shift+O".action = spawn ["playerctl" "play-pause"];
        "Mod+Shift+R".action = spawn (noctalia "screenRecorder toggle");
        "Mod+Shift+Z".action = spawn (noctalia "notifications toggleHistory");
        "Mod+Shift+M".action = spawn (noctalia "volume muteInput");
        "Mod+Shift+Escape".action = spawn (noctalia "sessionMenu toggle");
        "XF86AudioRaiseVolume".action = spawn (noctalia "volume increase");
        "XF86AudioLowerVolume".action = spawn (noctalia "volume decrease");
        "XF86AudioMute".action = spawn (noctalia "volume muteOutput");
      }
      // builtins.listToAttrs (lib.imap1 (index: name: {
          name = "Mod+${toString index}";
          value = {action = focus-workspace name;};
        })
        workspaces);

    workspaces = builtins.listToAttrs (map (name: {
        inherit name;
        value = {};
      })
      workspaces);

    layout = with config.lib.stylix.colors.withHashtag; {
      gaps = 8;
      default-column-width = {proportion = 0.5;};
      border.width = 2;
      background-color = "transparent";
      insert-hint.display.color = base0E;
    };

    window-rules = [
      {
        matches = [];
        geometry-corner-radius = let
          size = 12.0;
        in {
          top-left = size;
          top-right = size;
          bottom-right = size;
          bottom-left = size;
        };
        clip-to-geometry = true;
      }
      {
        matches = [{app-id = "pavucontrol";}];
        open-floating = true;
      }
      {
        matches = [{app-id = "vesktop";}];
        open-on-workspace = "III";
        default-column-width.proportion = 0.6;
      }
      {
        matches = [{app-id = "spotify";}];
        open-on-workspace = "III";
        default-column-width.proportion = 0.4;
      }
    ];

    layer-rules = [
      {
        matches = [{namespace = "wallpaper";}];
        place-within-backdrop = true;
      }
    ];

    input = {
      keyboard = {
        repeat-rate = 40;
        repeat-delay = 500;
      };
      mouse.accel-speed = 0.05;
    };

    animations.workspace-switch.enable = false;

    gestures.hot-corners.enable = false;

    prefer-no-csd = true;
    hotkey-overlay.skip-at-startup = true;
    overview = with config.lib.stylix.colors.withHashtag; {
      zoom = 0.5;
      backdrop-color = base01;
      workspace-shadow.enable = false;
    };

    xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;
  };

  xdg.portal = {
    config.niri = {
      default = "gtk";
      "org.freedesktop.impl.portal.Secret" = "gnome-keyring";
    };
    extraPortals = with pkgs; [xdg-desktop-portal-gtk];
  };
  services.cliphist.enable = true;
}
