{config, ...}: {
  flake.modules.darwin."hosts/hydra".imports = with config.flake.modules.darwin; [
    core
    shell
    arexon
    gui
    gaming
    stylix
  ];
}
