{config, ...}: {
  flake.modules.darwin."hosts/hydra".imports = with config.flake.modules.darwin; [
    ai
    core
    shell
    arexon
    gui
    gaming
    stylix
  ];
}
