{
  programs.walker = {
    enable = true;
    runAsService = true;
    config = {
      disable_mouse = true;
      force_keyboard_focus = true;
      providers.default = [
        "desktopapplications"
        "calc"
      ];
      keybinds = {
        close = ["ctrl bracketleft"];
        next = ["ctrl j"];
        previous = ["ctrl k"];
        quick_activate = [];
      };
    };
  };
}
