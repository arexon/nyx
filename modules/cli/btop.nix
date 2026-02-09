{
  flake.modules.homeManager.cli = {pkgs, ...}: {
    programs.btop = {
      enable = true;
      package = pkgs.btop.override {
        rocmSupport = true;
      };
      settings = {
        theme_background = false;
        vim_keys = true;
        rounded_corners = false;
        proc_gradient = false;
        base_10_sizes = true;
        update_ms = 500;
      };
    };

    xdg.desktopEntries.btop = {
      name = "";
      noDisplay = true;
    };
  };
}
