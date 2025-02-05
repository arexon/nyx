{pkgs, ...}: {
  nyx = {
    user = {
      name = "arexon";
      email = "arexonreal@gmail.com";
    };
    desktop = {
      gnome.enable = true;
      wallpapers.enable = true;
      gtk.enable = true;
    };
    apps = {
      ghostty.enable = true;
      blockbench.enable = true;
      discord.enable = true;
      firefox.enable = true;
      mpv.enable = true;
      obs.enable = true;
      spotify.enable = true;
      vscode.enable = true;
      obsidian.enable = true;
      lutris.enable = true;
    };
    games = {
      mcpelauncher.enable = true;
    };
    cli-apps = {
      btop.enable = true;
      fzf.enable = true;
      gadacz.enable = true;
      git.enable = true;
      helix.enable = true;
      lazygit.enable = true;
      nushell.enable = true;
      starship.enable = true;
      tmux.enable = true;
      yazi.enable = true;
      extraPackages = with pkgs; [
        wget
        p7zip
        rar
        tldr
        repgrep
      ];
    };
    tools = {
      direnv.enable = true;
      keychain.enable = true;
    };
    services = {
      ss-to-r2.enable = true;
    };
  };

  home.stateVersion = "24.05";
}
