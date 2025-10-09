{
  programs.walker = {
    enable = true;
    runAsService = true;
    config = {
      disable_mouse = true;
      force_keyboard_focus = true;
      keybinds = {
        close = ["ctrl bracketleft"];
        next = ["ctrl j"];
        previous = ["ctrl k"];
        quick_activate = [];
      };
    };
  };
}
