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
      shellAbbrs = {
        nhs = "nh os switch";
        nhb = "nh os boot";
        nht = "nh os test";
      };
      shellAliases = {
        cat = "bat";
        lg = "lazygit";
        tw = "timew";
      };
      binds = {
        "ctrl-l".command = "clear";
      };
      functions = let
        clear = "printf '\\e[H\\e[J\\e[100B'";
      in {
        fish_greeting = ''
          ${clear}
          fastfetch
        '';
        clear = ''
          ${clear}
          commandline -f repaint
        '';
        starship_transient_prompt_func = "starship module character";
        starship_transient_rprompt_func = "starship module time";
      };
    };
  };
}
