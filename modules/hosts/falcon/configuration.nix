{config, ...}: {
  flake.modules.nixos."hosts/falcon".imports = with config.flake.modules.nixos; [
    amdgpu
    arexon
    bluetooth
    kernel
    core
    gaming
    niri
    plymouth
    rex
    shell
    sound
    ssh
    stylix
    zsa
    tailscale
  ];
}
