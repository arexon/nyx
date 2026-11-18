{config, ...}: {
  flake.modules.nixos."hosts/leviathan" = with config.flake.modules.nixos; {
    imports = [
      agenix
      arexon
      core
      disko
      minecraft
      rex
      shell
      ssh
      stylix
      tailscale
      v-rising
    ];

    xdg = {
      autostart.enable = false;
      icons.enable = false;
      mime.enable = false;
      sounds.enable = false;
    };
  };
}
