{
  flake.modules.homeManager.cli = {
    programs.fastfetch = {
      enable = true;
      settings = {
        logo = {
          type = "file";
          source = ./boykisser.txt;
          color."1" = "magenta";
        };
        display = {
          separator = " ";
          color.separator = "yellow";
        };
        modules = [
          "break"
          "break"
          "break"
          "break"
          "break"
          "break"
          "break"
          "break"
          {
            type = "colors";
            key = "{#yellow}╭───";
            symbol = "circle";
          }
          {
            type = "os";
            key = "{#yellow}│ {#magenta} ";
            format = "{pretty-name} {sysname}";
          }
          {
            type = "kernel";
            key = "{#yellow}│ {#blue} ";
          }
          {
            type = "cpu";
            key = "{#yellow}│ {#magenta} ";
            showPeCoreCount = true;
            format = "{name}";
          }
          {
            type = "gpu";
            key = "{#yellow}│ {#blue}󰍹 ";
            format = "{name}";
          }
          {
            type = "packages";
            key = "{#yellow}│ {#magenta} ";
            format = "{nix-system} (system), {nix-user} (user)";
          }
          {
            type = "wm";
            key = "{#yellow}│ {#blue} ";
            format = "{pretty-name} {version}";
          }
          {
            type = "terminal";
            key = "{#yellow}│ {#magenta} ";
            format = "{pretty-name}";
          }
          {
            type = "shell";
            key = "{#yellow}│ {#blue} ";
            format = "{process-name}";
          }
          {
            type = "title";
            format = "{#yellow}╰─── {#magenta}{user-name}{#yellow}@{#blue}{host-name}";
          }
        ];
      };
    };
  };
}
