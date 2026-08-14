{
  flake.modules.homeManager.gui = {
    lib,
    pkgs,
    ...
  }: let
    inherit (pkgs.stdenv.hostPlatform) isDarwin isLinux;
  in {
    programs.ghostty = {
      enable = true;
      package =
        if isDarwin
        then pkgs.ghostty-bin
        else pkgs.ghostty;

      settings =
        {
          theme = "Catppuccin Mocha";

          font-family = "Iosevka NF";
          font-size =
            if isDarwin
            then 20
            else 14;
          font-feature = [
            "-calt"
            "-liga"
            "-dlig"
          ];

          background-opacity = 0.9;
          window-padding-x = 0;
          window-padding-y = 0;
          confirm-close-surface = false;
          unfocused-split-opacity = 1;
          mouse-scroll-multiplier = "precision:1,discrete:1";
          mouse-hide-while-typing = true;
          background-blur = "macos-glass-clear";

          keybind = [
            "ctrl+[=text:\\x1b"

            # Pane
            "ctrl+f>v=new_split:right"
            "ctrl+f>s=new_split:down"
            "ctrl+f>q=close_surface"
            "ctrl+f>h=goto_split:left"
            "ctrl+f>l=goto_split:right"
            "ctrl+f>k=goto_split:up"
            "ctrl+f>j=goto_split:down"
            "ctrl+f>r=activate_key_table:resize_pane"

            # Tabs
            "ctrl+f>t=new_tab"
            "ctrl+f>shift+t=prompt_tab_title"
            "ctrl+f>shift+q=close_tab"
            "ctrl+f>p=previous_tab"
            "ctrl+f>n=next_tab"
            "ctrl+f>shift+p=move_tab:-1"
            "ctrl+f>shift+n=move_tab:1"
            "ctrl+f>1=goto_tab:1"
            "ctrl+f>2=goto_tab:2"
            "ctrl+f>3=goto_tab:3"
            "ctrl+f>4=goto_tab:4"
            "ctrl+f>5=goto_tab:5"
            "ctrl+f>6=goto_tab:6"
            "ctrl+f>7=goto_tab:7"
            "ctrl+f>8=goto_tab:8"

            # Search
            "ctrl+f>shift+c=start_search"

            # Resize pane mode
            "resize_pane/"
            "resize_pane/h=resize_split:left,50"
            "resize_pane/l=resize_split:right,50"
            "resize_pane/k=resize_split:up,50"
            "resize_pane/j=resize_split:down,50"
            "resize_pane/escape=deactivate_key_table"
            "resize_pane/ctrl+[=deactivate_key_table"
          ];
        }
        // lib.optionalAttrs isLinux {
          gtk-tabs-location = "bottom";
          window-show-tab-bar = "always";
        };
    };
  };
}
