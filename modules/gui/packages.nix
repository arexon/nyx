{
  inputs,
  system,
  ...
}: {
  flake.modules.homeManager.gui = {pkgs, ...}: {
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
      gnome-text-editor
      vscode
      # inputs.zed-editor-flake.packages.${pkgs.stdenv.hostPlatform.system}.zed-editor-preview-bin
    ];

    xdg.desktopEntries."org.gnome.Totem" = {
      name = "";
      noDisplay = true;
    };
  };
}
