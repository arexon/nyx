{
  programs.mpv = {
    enable = true;
    config = {
      gpu-api = "opengl";
      screenshot-directory = "~/Pictures/mpv-screenshots";
      screenshot-format = "png";
    };
  };
}
