{
  flake.modules.homeManager.gui = {pkgs, ...}: {
    home.packages = with pkgs; [
      blockbench
      obsidian
      gimp
      unstable.kdePackages.kdenlive
      losslesscut-bin
      totem # Apparently video thumbnails require this..
      file-roller
      nautilus
      pavucontrol
      crosspipe
      gnome-text-editor
      vscode
    ];

    xdg.desktopEntries."org.gnome.Totem" = {
      name = "";
      noDisplay = true;
    };
  };
}
