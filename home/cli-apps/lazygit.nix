{
  programs.lazygit = {
    enable = true;
    settings = {
      gui = {
        skipDiscardChangeWarning = true;
        showCommandLog = false;
      };
      git.overrideGpg = true;
    };
  };
}
