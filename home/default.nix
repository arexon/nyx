{user, ...}: {
  imports = [
    ./desktop
    ./gui-apps
    ./cli-apps
    ./games.nix
    ./stylix.nix
    ./xdg.nix
  ];

  home = {
    username = user;
    homeDirectory = "/home/${user}";
  };

  home.stateVersion = "24.05";
}
