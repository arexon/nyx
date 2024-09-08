{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.nyx.cli-apps.btop;
in {
  options.nyx.cli-apps.btop = {
    enable = mkBoolOpt false "Whether to enable btop.";
  };

  config = mkIf cfg.enable {
    xdg.desktopEntries.btop = {
      name = "";
      noDisplay = true;
    };

    programs.btop = {
      enable = true;
      package = pkgs.btop.override {cudaSupport = true;};
      settings = {
        color_theme = "TTY";
        theme_background = false;
        vim_keys = true;
        rounded_corners = false;
        proc_gradient = false;
        shown_boxes = "proc cpu mem net gpu0";
        base_10_sizes = true;
      };
    };
  };
}
