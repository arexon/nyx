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
      firefox.enable = true;
    };
    cli-apps = {
      btop.enable = true;
      fzf.enable = true;
      git.enable = true;
      helix.enable = true;
      nushell.enable = true;
      starship.enable = true;
      tmux.enable = true;
      yazi.enable = true;
      extraPackages = with pkgs; [wget hyperfine serpl];
    };
    tools = {
      direnv.enable = true;
      keychain.enable = true;
    };
  };

  home.stateVersion = "24.05";
}
