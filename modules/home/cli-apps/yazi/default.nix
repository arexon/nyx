{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.nyx.cli-apps.yazi;
in {
  options.nyx.cli-apps.yazi = {
    enable = mkBoolOpt false "Whether to enable Yazi.";
  };

  config = mkIf cfg.enable {
    xdg = {
      configFile."yazi/init.lua".text = builtins.readFile ./init.lua;
      desktopEntries.yazi = {
        name = "";
        noDisplay = true;
      };
    };

    home.packages = with pkgs; [ueberzugpp];

    programs.yazi = {
      enable = true;
      enableNushellIntegration = true;
      settings = {
        manager = {
          ratio = [0 4 8];
          sort_by = "natural";
          sort_reverse = false;
          sort_dir_first = true;
          linemode = "size";
          show_hidden = true;
        };
      };
      theme = {
        manager = {
          preview_hovered.underline = false;

          folder_offset = [2 2 2 2];
          preview_offset = [2 2 2 2];

          border_symbol = " ";
        };
      };
      keymap.manager.append_keymap = [
        {
          on = ["g" "m"];
          run = "cd ~/com.mojang";
          desc = "Go to com.mojang directory";
        }
      ];
    };
  };
}
