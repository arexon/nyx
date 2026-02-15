{config, ...}: {
  flake.modules.nixos."hosts/leviathan" = with config.flake.modules.nixos; {
    imports = [
      agenix
      arexon
      core
      disko
      shell
      ssh
      hytale
    ];
  };
}
