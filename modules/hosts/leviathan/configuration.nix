{
  inputs,
  config,
  ...
}: {
  flake-file.inputs = {
    hytale-server = {
      url = "github:essegd/hytale-server-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  flake.modules.nixos."hosts/leviathan" = with config.flake.modules.nixos; {
    imports = [
      agenix
      arexon
      core
      disko
      root
      shell
      ssh
      inputs.hytale-server.nixosModules.hytale-servers
    ];

    services.hytale-servers = {
      enable = true;
      servers = {
        main = {
          enable = true;
          listenAddress = "0.0.0.0";
          openFirewall = true;
          patchline = "release";
          autoUpdate = true;
          restart = "no";
          tmux.enable = true;
        };
      };
    };
  };
}
