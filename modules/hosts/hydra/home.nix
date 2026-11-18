{config, ...}: {
  flake.modules.homeManager."homes/arexon@hydra".imports = with config.flake.modules.homeManager; [
    arexon
    cli
    core
    fonts
    gaming
    git
    gui
    helix
    mac-app-util
    rex
    shell
    stylix
    xdg
  ];
}
