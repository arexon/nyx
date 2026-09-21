{config, ...}: {
  flake.modules.nixos."hosts/leviathan" = with config.flake.modules.nixos; {
    imports = [
      agenix
      arexon
      core
      disko
      hytale
      minecraft
      shell
      ssh
      stylix
      tailscale
      v-rising
    ];
  };
}
