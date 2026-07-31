{config, ...}: {
  flake.modules.homeManager."homes/arexon@hydra".imports = with config.flake.modules.homeManager; [
    ai
    arexon
    cli
    core
    fonts
    gaming
    git
    gui
    helix
    shell
    stylix
  ];
}
