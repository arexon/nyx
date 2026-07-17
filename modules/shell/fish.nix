{
  flake.modules.homeManager.shell = {pkgs, ...}: {
    programs.fish = {
      enable = true;
      plugins = [
        {
          name = "autopair";
          inherit (pkgs.fishPlugins.autopair) src;
        }
      ];
      shellAliases = {
        cat = "bat";
        lg = "lazygit";
        tw = "timew";
      };
      binds = {
        "ctrl-l".command = "clear";
        "ctrl-h".command = "backward-kill-word";
      };
      functions = let
        clear = "printf '\\e[H\\e[J\\e[100B'";
      in {
        fish_greeting = ''
          ${clear}
          if command -q fastfetch
            fastfetch
          end
        '';
        clear = ''
          ${clear}
          commandline -f repaint
        '';
        starship_transient_prompt_func = "starship module character";
        starship_transient_rprompt_func = "starship module time";
      };
    };

    programs.helix.settings.editor.shell = ["fish" "-c"];
  };
}
