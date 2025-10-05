{user, ...}: {
  imports = [
    ./colorscheme.nix
    ./desktop
    ./gui-apps
    ./cli-apps
    ./games.nix
  ];

  home = {
    username = user;
    homeDirectory = "/home/${user}";
  };
  xdg.enable = true;

  home.stateVersion = "24.05";
}
