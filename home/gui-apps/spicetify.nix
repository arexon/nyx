{
  programs.spicetify = {
    enable = true;
    wayland = true;
  };

  programs.niri.settings = {
    window-rules = [
      {
        matches = [{app-id = "^spotify$";}];
        open-on-workspace = "III";
        default-column-width.proportion = 0.3;
      }
    ];
  };
}
