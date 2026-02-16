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
        files = with pkgs; {
          "mods/ItemDisplays.jar".source = fetchurl {
            url = "https://www.curseforge.com/api/v1/mods/1438861/files/7554548/download";
            sha512 = "3yjg9606yvaqz0xsf1mi91nl5fz5zbkv5idwwr2lqvp9qjhavcd92n9mfydi9r6949y03jqzs1xdhyam2rd5cxddkpnbjcbc9gi2y7v";
          };
          "mods/SignaturePreservation.jar".source = fetchurl {
            url = "https://www.curseforge.com/api/v1/mods/1446007/files/7553748/download";
            sha512 = "06pfhh75gxyjy460myxx92kl8b8mkhqhbaxgy1w3l6i5wi06ba3mz6rm43z3w130xhdpycl5shqxbcksacsg224ylll5pn759kqw684";
          };
          "mods/TextSigns.jar".source = fetchurl {
            url = "https://www.curseforge.com/api/v1/mods/1430832/files/7586850/download";
            sha512 = "0p2pil1szidpslblsh2g2n2pdr64apmhlb9z9vykmb0x6hk8klvld6lz3mvyp797ky258wswphab288ifxlwp76f6sq2jpmlfi8k7ac";
          };
        };
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
