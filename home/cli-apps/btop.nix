{
  programs.btop = {
    enable = true;
    settings = {
      color_theme = "TTY";
      theme_background = false;
      vim_keys = true;
      rounded_corners = false;
      proc_gradient = false;
      base_10_sizes = true;
    };
  };

  xdg.desktopEntries.btop = {
    name = "";
    noDisplay = true;
  };
}
