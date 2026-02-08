{
  flake.modules.homeManager.gui = {config, ...}: {
    programs.mpv = {
      enable = true;
      config = {
        gpu-api = "opengl";
        screenshot-directory = "${config.xdg.userDirs.pictures}/mpv-screenshots";
        screenshot-format = "png";
      };
    };
  };
}
