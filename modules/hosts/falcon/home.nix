{config, ...}: {
  flake.modules.homeManager."homes/arexon@falcon:x86_64-linux".imports = with config.flake.modules.homeManager; [
    arexon
    cli
    core
    environment
    fonts
    gaming
    git
    gui
    helix
    niri
    noctalia
    shell
    stylix
    xdg
  ];
}
