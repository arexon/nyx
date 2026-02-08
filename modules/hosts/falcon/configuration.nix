{config, ...}: {
  flake.modules.nixos."hosts/falcon".imports = with config.flake.modules.nixos; [
    agenix
    amdgpu
    arexon
    bluetooth
    core
    gaming
    kanata
    niri
    plymouth
    root
    shell
    sound
    ssh
    stylix
  ];
}
