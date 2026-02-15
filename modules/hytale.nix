{inputs, ...}: {
  flake-file.inputs = {
    hytale-server = {
      url = "github:essegd/hytale-server-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  flake.modules.nixos.hytale = {
    pkgs,
    config,
    ...
  }: let
    name = "main";
  in {
    imports = [inputs.hytale-server.nixosModules.hytale-servers];

    environment.systemPackages = [pkgs.tmux];

    services.hytale-servers = {
      enable = true;
      servers.${name} = {
        enable = true;
        openFirewall = true;
        patchline = "release";
        autoUpdate = true;
        restart = "no";
        tmux.enable = true;
      };
    };

    services.restic.backups.hytale = {
      initialize = true;
      paths = ["${config.services.hytale-servers.dataDir}/${name}/universe"];
      passwordFile = config.age.secrets.restic-password.path;
      pruneOpts = [
        "--keep-weekly 3"
        "--keep-monthly 4"
        "--keep-yearly 8"
      ];
      timerConfig = {
        OnCalendar = "daily";
        Persistent = true;
      };
      repository = "s3:706f2c4fa9dc13b59493dae2d2b7b85a.r2.cloudflarestorage.com/hytale";
      environmentFile = config.age.secrets.restic-r2-environment.path;
    };
  };
}
