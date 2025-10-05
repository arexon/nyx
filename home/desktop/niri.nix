{pkgs, ...}: {
  programs.niri.settings.binds = {
    "Mod+Return".action.spawn = "wezterm";
    "Mod+Space".action.spawn = "fuzzel";
  };

  home.packages = with pkgs; [fuzzel];
}
