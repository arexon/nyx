{pkgs, ...}: {
  imports = [
    ./discord.nix
    ./obs.nix
    ./spicetify.nix
    ./wezterm
  ];

  home.packages = with pkgs; [
    blockbench
    obsidian
    gimp
    kdePackages.kdenlive
    losslesscut-bin
    firefox
    totem # Apparently video thumbnails require this..
    file-roller
    nautilus
    pavucontrol
    helvum
    celluloid
    loupe
  ];

  xdg.desktopEntries."org.gnome.Totem" = {
    name = "";
    noDisplay = true;
  };
}
