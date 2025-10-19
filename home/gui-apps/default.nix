{pkgs, ...}: {
  imports = [
    ./discord.nix
    ./mpv.nix
    ./obs.nix
    ./spicetify.nix
    ./wezterm
  ];

  home.packages = with pkgs; [
    blockbench
    obsidian
    gimp
    kdePackages.kdenlive
    pinta
    losslesscut-bin
    firefox
    vscode
    totem # Apparently video thumbnails require this..
    file-roller
    nautilus
    papers
    gamepad-tool
    pavucontrol
    helvum
  ];

  xdg.desktopEntries."org.gnome.Totem" = {
    name = "";
    noDisplay = true;
  };
}
