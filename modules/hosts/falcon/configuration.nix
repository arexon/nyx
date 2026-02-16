{config, ...}: {
  flake.modules.nixos."hosts/falcon".imports = with config.flake.modules.nixos; [
    amdgpu
    arexon
    bluetooth
    core
    gaming
    kanata
    niri
    plymouth
    shell
    sound
    ssh
    stylix
  ];
}
