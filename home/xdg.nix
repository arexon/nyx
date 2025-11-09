{config, ...}: {
  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      download = "${config.home.homeDirectory}/dl";
      videos = "${config.home.homeDirectory}/vids";
      pictures = "${config.home.homeDirectory}/pics";
      documents = "${config.home.homeDirectory}/docs";
    };
  };
}
