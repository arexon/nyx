{config, ...}: {
  flake.modules.homeManager."homes/arexon@leviathan:x86_64-linux".imports = with config.flake.modules.homeManager; [
    arexon
    cli
    core
    git
    helix
    shell
    xdg
  ];
}
