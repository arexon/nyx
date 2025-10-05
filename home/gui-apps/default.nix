{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.nixcord.homeModules.nixcord
    ./discord.nix
    ./mpv.nix
    ./obs.nix
  ];

  home.packages = with pkgs; [
    totem # Apparently video thumbnails require this..
    spotify
    blockbench
    obsidian
    krita
    kdePackages.kdenlive
    pinta
    losslesscut-bin
    firefox
    wezterm
    vscode
  ];

  xdg.desktopEntries."org.gnome.Totem" = {
    name = "";
    noDisplay = true;
  };
}
