{config, ...}: {
  flake.modules.homeManager."homes/arexon@leviathan".imports = with config.flake.modules.homeManager; [
    arexon
    cli
    core
    git
    helix
    shell
    stylix
    xdg
  ];
}
