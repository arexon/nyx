{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.nyx.desktop.gnome;

  extensions = with pkgs.gnomeExtensions; [
    appindicator
    clipboard-history
    blur-my-shell
    custom-accent-colors
    just-perfection
    unite
    hibernate-status-button
  ];

  customKeybinds = "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings";
in {
  options.nyx.desktop.gnome = {
    enable = mkBoolOpt false "Whether to configure GNOME.";
  };

  config = mkIf cfg.enable {
    home.packages = extensions;

    xdg.userDirs = {
      enable = true;
      createDirectories = true;
      desktop = null;
      music = null;
      publicShare = null;
      templates = null;
    };

    dconf.settings = {
      "org/gnome/shell".enabled-extensions = builtins.map (ext: ext.extensionUuid) extensions ++ ["user-theme@gnome-shell-extensions.gcampax.github.com"];

      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
        enable-hot-corners = false;
      };

      "org/gnome/desktop/sound".event-sounds = false;

      "org/gnome/desktop/background".picture-uri-dark = config.nyx.desktop.wallpapers.list.bridge;

      "org/gnome/desktop/screensaver".picture-uri-dark = config.nyx.desktop.wallpapers.list.bridge;

      "org/gnome/desktop/search-providers".disabled = [
        "com.github.FontManager.FontManager.desktop"
        "org.gnome.Settings.desktop"
        "org.gnome.Weather.desktop"
      ];

      "org/gnome/desktop/wm/preferences" = {
        button-layout = [];
        num-workspaces = 6;
      };
      "org/gnome/desktop/wm/keybindings" = {
        move-to-monitor-down = [];
        move-to-monitor-left = [];
        move-to-monitor-right = [];
        move-to-monitor-up = [];
        move-to-workspace-left = ["<Alt><Super>h"];
        move-to-workspace-right = ["<Alt><Super>l"];
        move-to-workspace-last = [];
        move-to-workspace-1 = [];
        switch-applications = ["<Alt>Tab"];
        switch-applications-backward = [];
        switch-panels = [];
        switch-panels-backward = [];
        cycle-panels = [];
        cycle-panels-backward = [];
        switch-to-last-workspace = [];
        switch-to-workspace-1 = ["<Super>1"];
        switch-to-workspace-2 = ["<Super>2"];
        switch-to-workspace-3 = ["<Super>3"];
        switch-to-workspace-4 = ["<Super>4"];
        switch-to-workspace-5 = ["<Super>5"];
        switch-to-workspace-6 = ["<Super>6"];
        switch-to-workspace-left = [];
        switch-to-workspace-right = [];
        switch-windows = ["<Super>Tab"];
        switch-windows-backward = [];
        cycle-windows = [];
        cycle-windows-backward = [];
        cycle-group = [];
        cycle-group-backward = [];
        switch-group = [];
        switch-group-backward = [];
        panel-run-dialog = [];
        switch-input-source = [];
        switch-input-source-backward = [];
        activate-window-menu = [];
        close = ["<Super>q"];
        minimize = [];
        maximize = [];
        unmaximize = [];
        begin-move = [];
        begin-resize = [];
        toggle-maximized = ["<Super>f"];
      };

      "org/gnome/shell/keybindings" = {
        show-screen-recording-ui = [];
        screenshot = ["<Super>Print"];
        show-screenshot-ui = ["<Shift><Super>s"];
        screenshot-window = ["<Shift><Control><Super>s"];
        focus-active-notification = ["<Super>w"];
        switch-to-application-1 = [];
        switch-to-application-2 = [];
        switch-to-application-3 = [];
        switch-to-application-4 = [];
        switch-to-application-5 = [];
        switch-to-application-6 = [];
        switch-to-application-7 = [];
        switch-to-application-8 = [];
        switch-to-application-9 = [];
        switch-to-application-10 = [];
      };

      "org/gnome/mutter/wayland/keybindings".restore-shortcut = [];
      "org/gnome/mutter/keybindings" = {
        toggle-tiled-left = ["<Super>h"];
        toggle-tiled-right = ["<Super>l"];
      };

      "org/gnome/settings-daemon/plugins/power" = {
        sleep-inactive-ac-type = "suspend";
        sleep-inactive-ac-timeo = 1200;
      };

      "org/gnome/settings-daemon/plugins/media-keys" = {
        screenreader = [];
        screensaver = [];
        magnifier = [];
        magnifier-zoom-in = [];
        magnifier-zoom-out = [];
        help = [];
        control-center = ["<Super>i"];
        next = ["<Alt><Super>n"];
        play = ["<Alt><Super>o"];
        previous = ["<Alt><Super>p"];
        volume-up = ["<Alt><Super>k"];
        volume-down = ["<Alt><Super>j"];
        volume-mute = ["<Alt><Super>u"];
        logout = ["<Super>Escape"];
        custom-keybindings = with lib.lists; let
          inherit (config.nyx) apps;
        in
          builtins.map (bind: "/${customKeybinds}/${bind}/")
          (["open-nautilus"]
            ++ (optionals apps.firefox.enable ["open-firefox"])
            ++ (optionals apps.alacritty.enable ["open-alacritty"]));
      };
      "${customKeybinds}/open-nautilus" = {
        name = "Open Nautilus";
        command = "nautilus";
        binding = "<Super>e";
      };
      "${customKeybinds}/open-firefox" = {
        name = "Open Firefox";
        command = "firefox";
        binding = "<Super>b";
      };
      "${customKeybinds}/open-alacritty" = {
        name = "Open Alacritty";
        command = "alacritty";
        binding = "<Super>Return";
      };

      "org/gnome/nautilus/list-view".default-zoom-level = "small";
      "org/gnome/nautilus/icon-view".default-zoom-level = "large";
      "org/gnome/nautilus/preferences".click-policy = "single";

      "org/gtk/gtk4/settings/file-chooser" = {
        show-hidden = true;
        window-size = lib.hm.gvariant.mkTuple [900 650];
      };

      "org/gnome/shell/extensions/just-perfection" = {
        activities-button = false;
        events-button = false;
        search = false;
        show-apps-button = false;
        workspace = false;
        workspace-popup = false;
        window-preview-close-button = false;
        window-preview-caption = false;
        window-menu-take-screenshot-button = false;
        double-super-to-appgrid = false;
        startup-status = 0;
        clock-menu-position = 1;
        clock-menu-position-offset = 10;
      };

      "org/gnome/shell/extensions/unite" = {
        hide-window-titlebars = "always";
        show-window-buttons = "never";
      };

      "org/gnome/shell/extensions/custom-accent-color" = {
        accent-color = "pink";
        theme-gtk = true;
        theme-shell = true;
      };

      "org/gnome/shell/extensions/user-theme".name = "Custom-Accent-Colors";

      "org/gnome/shell/extensions/hibernate-status-button" = {
        show-hybrid-sleep = false;
        show-suspend-then-hibernate = false;
      };
    };
  };
}
