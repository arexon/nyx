{pkgs, ...}: {
  programs.yazi = {
    enable = true;
    enableNushellIntegration = true;
    plugins = with pkgs.yaziPlugins; {
      git = git;
      smart-enter = smart-enter;
    };
    initLua = ./init.lua;
    theme.icon.dirs = [
      {
        name = ".config";
        text = "";
      }
      {
        name = ".git";
        text = "";
      }
      {
        name = ".github";
        text = "";
      }
      {
        name = "desktop";
        text = "";
      }
      {
        name = "docs";
        text = "";
      }
      {
        name = "dl";
        text = "";
      }
      {
        name = "pics";
        text = "";
      }
      {
        name = "vids";
        text = "";
      }
      {
        name = "games";
        text = "";
      }
      {
        name = "projects";
        text = "";
      }
    ];
    settings = {
      plugin = {
        prepend_fetchers = [
          {
            id = "git";
            name = "*";
            run = "git";
          }
          {
            id = "git";
            name = "*/";
            run = "git";
          }
        ];
      };
      mgr = {
        ratio = [0 4 8];
        sort_by = "natural";
        sort_reverse = false;
        sort_dir_first = true;
        linemode = "size";
        show_hidden = true;
      };
      tasks.suppress_preload = true;
    };
    theme = {
      mgr = {
        preview_hovered.underline = false;

        folder_offset = [2 2 2 2];
        preview_offset = [2 2 2 2];

        border_symbol = " ";
      };
    };
    keymap.mgr.prepend_keymap = [
      {
        on = ["g" "m"];
        run = "cd ~/com.mojang";
        desc = "Go ~/com.mojang";
      }
      {
        on = ["g" "d"];
        run = "cd ~/dl";
        desc = "Go ~/dl";
      }
      {
        on = ["g" "v"];
        run = "cd ~/vids";
        desc = "Go ~/vids";
      }
      {
        on = ["g" "p"];
        run = "cd ~/pics";
        desc = "Go ~/pics";
      }

      {
        on = ["l"];
        run = "plugin smart-enter";
        desc = "Enter the child directory, or open the file";
      }
    ];
  };

  xdg.desktopEntries.yazi = {
    name = "";
    noDisplay = true;
  };
}
