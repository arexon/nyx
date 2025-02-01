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
    just-perfection
    unite
    hibernate-status-button
    paperwm
  ];

  purpleColor = "rgb(149,127,184)";
  customKeybinds = "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings";
in {
  options.nyx.desktop.gnome = {
    enable = mkBoolOpt false "Whether to configure GNOME.";
  };

  config = mkIf cfg.enable {
    home.packages =
      (with pkgs; [
        file-roller
        loupe
        nautilus
        papers
        gnome-text-editor
        gnome-weather
      ])
      ++ extensions;

    xdg.userDirs = {
      enable = true;
      createDirectories = true;
      desktop = null;
      music = null;
      publicShare = null;
      templates = null;
    };

    dconf.settings = {
      "org/gnome/shell".enabled-extensions = builtins.map (ext: ext.extensionUuid) extensions;

      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
        accent-color = "pink";
        enable-hot-corners = false;
      };

      "org/gnome/desktop/sound".event-sounds = false;

      "org/gnome/desktop/background".picture-uri-dark = config.nyx.desktop.wallpapers.list.samurai;

      "org/gnome/desktop/screensaver".picture-uri-dark = config.nyx.desktop.wallpapers.list.samurai;

      "org/gnome/desktop/search-providers".disabled = [
        "com.github.FontManager.FontManager.desktop"
        "org.gnome.Settings.desktop"
        "org.gnome.Weather.desktop"
      ];

      "org/gnome/desktop/wm/preferences" = {
        button-layout = [];
        num-workspaces = 4;
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
      };

      "org/gnome/shell/keybindings" = {
        show-screen-recording-ui = [];
        screenshot = ["<Super>Print"];
        show-screenshot-ui = ["<Shift><Super>s"];
        screenshot-window = ["<Shift><Control><Super>s"];
        focus-active-notification = [];
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
      "org/gnome/mutter".center-new-windows = true;

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
        custom-keybindings = [
          "/${customKeybinds}/open-nautilus/"
          "/${customKeybinds}/open-firefox/"
          "/${customKeybinds}/open-ghostty/"
        ];
      };
      "${customKeybinds}/open-nautilus" = {
        name = "Open Nautilus";
        command = "nautilus";
        binding = "<Super>e";
      };
      "${customKeybinds}/open-firefox" = {
        name = "Open Firefox";
        command = "firefox";
        binding = "<Super>w";
      };
      "${customKeybinds}/open-ghostty" = {
        name = "Open Ghostty";
        command = "ghostty";
        binding = "<Super>Return";
      };

      "org/gnome/nautilus/list-view".default-zoom-level = "small";
      "org/gnome/nautilus/icon-view".default-zoom-level = "large";

      "org/gtk/gtk4/settings/file-chooser" = {
        show-hidden = true;
        window-size = lib.hm.gvariant.mkTuple [900 650];
      };

      "org/gnome/shell/extensions/just-perfection" = {
        dash = false;
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
        panel-size = 40;
        notification-banner-position = 5;
      };

      "org/gnome/shell/extensions/unite" = {
        hide-window-titlebars = "always";
        show-window-buttons = "never";
      };

      "org/gnome/shell/extensions/hibernate-status-button" = {
        show-hybrid-sleep = false;
        show-suspend-then-hibernate = false;
      };

      "org/gnome/shell/extensions/paperwm" = {
        show-workspace-indicator = false;
        gesture-enabled = false;
        selection-border-size = 0;
        selection-border-radius = 0;
        window-gap = 0;
        horizontal-margin = 0;
        vertical-margin = 0;
        vertical-margin-bottom = 0;
        winprops = mkIf config.nyx.games.mcpelauncher.enable (map builtins.toJSON [
          {
            wm_class = "Minecraft";
            scratch_layer = true;
          }
        ]);
      };
      "org/gnome/shell/extensions/paperwm/keybindings" = {
        new-window = ["<Super>n"];
        close-window = [];
        switch-next = ["<Super>l"];
        switch-previous = ["<Super>h"];
        switch-left = [];
        switch-right = [];
        switch-up = [];
        switch-down = [];
        switch-first = [];
        switch-last = [];
        live-alt-tab = [];
        live-alt-tab-backward = [];
        live-alt-tab-scratch = [];
        live-alt-tab-scratch-backward = [];
        switch-focus-mode = [];
        switch-open-window-position = [];
        move-left = ["<Shift><Super>h"];
        move-right = ["<Shift><Super>l"];
        move-up = ["<Shift><Super>k"];
        move-down = ["<Shift><Super>j"];
        slurp-in = [];
        barf-out = [];
        barf-out-active = [];
        cycle-width = [];
        cycle-width-backwards = [];
        cycle-height = [];
        cycle-height-backwards = [];
        take-window = [];
        previous-workspace = [];
        previous-workspace-backward = [];
        move-previous-workspace = [];
        move-previous-workspace-backward = [];
        switch-up-workspace = ["<Super>k"];
        switch-down-workspace = ["<Super>j"];
        move-up-workspace = ["<Control><Super>k"];
        move-down-workspace = ["<Control><Super>j"];
        toggle-scratch-layer = ["<Super>z"];
        toggle-scratch = ["<Shift><Super>z"];
        toggle-scratch-window = [];
        open-window-position-option-down = false;
      };
      "org/gnome/shell/extensions/paperwm/workspaces".list = ["one" "two" "three" "four"];
      "org/gnome/shell/extensions/paperwm/workspaces/one" = {
        index = 0;
        color = purpleColor;
      };
      "org/gnome/shell/extensions/paperwm/workspaces/two" = {
        index = 1;
        color = purpleColor;
      };
      "org/gnome/shell/extensions/paperwm/workspaces/three" = {
        index = 2;
        color = purpleColor;
      };
      "org/gnome/shell/extensions/paperwm/workspaces/four" = {
        index = 3;
        color = purpleColor;
      };
    };
  };
}
