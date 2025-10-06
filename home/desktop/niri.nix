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

  inherit (config.colorscheme) palette;
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
        "Mod+Space".action = spawn (noctalia "launcher toggle");
        "Mod+Return".action = spawn "wezterm";
        "Mod+W".action = spawn "firefox";
        "Mod+E".action = spawn "nautilus";
        "Mod+Q".action = close-window;
        "Mod+F".action = maximize-column;
        "Mod+Shift+F".action = fullscreen-window;
        "Mod+H".action = focus-column-left;
        "Mod+L".action = focus-column-right;
        "Mod+Shift+H".action = move-column-left;
        "Mod+Shift+L".action = move-column-right;
        "Mod+Shift+Equal".action = consume-window-into-column;
        "Mod+Shift+Minus".action = expel-window-from-column;
        "Mod+Shift+J".action = move-column-to-workspace-down;
        "Mod+Shift+K".action = move-column-to-workspace-up;
        "Mod+Z".action = toggle-window-floating;
        "Mod+Tab".action = focus-workspace-previous;
        "Mod+Equal".action = set-column-width "+10%";
        "Mod+Minus".action = set-column-width "-10%";
        "XF86AudioRaiseVolume".action = spawn (noctalia "volume increase");
        "XF86AudioLowerVolume".action = spawn (noctalia "volume decrease");
        "XF86AudioMute".action = spawn (noctalia "volume muteOutput");
        "Mod+Shift+S".action = screenshot;
        # TODO: Swap to an option once added to the niri-flake.
        "Mod+F12".action.screenshot-screen = [];
        "Mod+Shift+V".action = spawn (noctalia "launcher clipboard");
        "Mod+Escape".action = spawn (noctalia "sessionMenu toggle");
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

    layout = {
      gaps = 8;
      always-center-single-column = true;
      default-column-width = {proportion = 0.5;};
      focus-ring = {
        width = 2;
        active.color = palette.base0E;
        urgent.color = palette.base08;
      };
      background-color = palette.base01;
      insert-hint.display.color = palette.base0E;
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
    cursor.theme = config.gtk.cursorTheme.name;
    overview = {
      zoom = 0.5;
      backdrop-color = palette.base01;
      workspace-shadow.enable = false;
    };
  };

  xdg.portal = {
    config.niri = {
      default = ["gnome" "gtk"];
      "org.freedesktop.impl.portal.Access" = "gtk";
      "org.freedesktop.impl.portal.Notification" = "gtk";
      "org.freedesktop.impl.portal.Secret" = "gnome-keyring";
      "org.freedesktop.impl.portal.FileChooser" = "gtk";
    };
    extraPortals = [pkgs.xdg-xdg-desktop-portal-gtk];
  };
  services.cliphist.enable = true;

  home.packages = with pkgs; [xwayland-satellite];
}
