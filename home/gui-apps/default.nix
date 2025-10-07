{pkgs, ...}: {
  imports = [
    ./discord.nix
    ./mpv.nix
    ./obs.nix
    ./spicetify.nix
  ];

  home.packages = with pkgs; [
    blockbench
    obsidian
    krita
    kdePackages.kdenlive
    pinta
    losslesscut-bin
    firefox
    wezterm
    vscode
    totem # Apparently video thumbnails require this..
    file-roller
    loupe
    nautilus
    papers
  ];

  xdg.desktopEntries."org.gnome.Totem" = {
    name = "";
    noDisplay = true;
  };
}
