{
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    enableTransience = true;
    settings = {
      format = builtins.concatStringsSep "" [
        "$directory"
        "$git_branch"
        "$git_status"
        "$nix_shell"
        "$direnv"
        "$line_break"
        "$character"
      ];
      directory = {
        format = ''[$path]($style)[$read_only]($read_only_style)'';
        style = "blue bold";
        read_only = "[]";
        read_only_style = "blue";
      };
      git_branch = {
        format = " [$branch]($style)";
        style = "purple bold";
      };
      git_status = {
        format = ''[\[$all_status$ahead_behind\]]($style)'';
        style = "purple";
      };
      nix_shell = {
        format = " [[nix]($style bold)\\[$state\\]]($style)";
        style = "yellow";
      };
      direnv = {
        format = " [$symbol]($style bold)";
        symbol = "direnv";
        style = "green";
        disabled = false;
      };
      character = {
        success_symbol = "[::](bold green)";
        error_symbol = "[:X](bold red)";
      };
      time.disabled = false;
    };
  };
}
