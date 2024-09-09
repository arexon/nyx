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
      alacritty.enable = true;
      blockbench.enable = true;
      discord.enable = true;
      firefox.enable = true;
      obs.enable = true;
      spotify.enable = true;
    };
    games = {
      mcpelauncher.enable = true;
    };
    cli-apps = {
      btop.enable = true;
      fzf.enable = true;
      git.enable = true;
      helix.enable = true;
      lazygit.enable = true;
      nushell.enable = true;
      starship.enable = true;
      tmux.enable = true;
      yazi.enable = true;
      extraPackages = with pkgs; [wget hyperfine serpl diskonaut];
    };
    tools = {
      direnv.enable = true;
      keychain.enable = true;
    };
  };

  home.stateVersion = "24.05";
}
