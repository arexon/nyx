{user, ...}: {
  imports = [
    ./desktop
    ./gui-apps
    ./cli-apps
    ./games.nix
    ./stylix.nix
  ];

  home = {
    username = user;
    homeDirectory = "/home/${user}";
  };
  xdg.enable = true;

  home.stateVersion = "24.05";
}
