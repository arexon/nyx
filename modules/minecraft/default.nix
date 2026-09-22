{inputs, ...}: {
  flake-file.inputs.nix-minecraft = {
    url = "github:Infinidoge/nix-minecraft";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  flake.modules.nixos.minecraft = {
    pkgs,
    lib,
    ...
  }: {
    imports = [inputs.nix-minecraft.nixosModules.minecraft-servers];

    nixpkgs.overlays = [inputs.nix-minecraft.overlay];

    # tmux console: tmux -S /run/minecraft/main.sock attach
    users.users.arexon.extraGroups = ["minecraft"];

    services.minecraft-servers = {
      enable = true;
      eula = true;
      servers.main = {
        enable = true;
        package = pkgs.neoforgeServers.neoforge-1_21_1-21_1_249;
        jvmOpts = "-Xms8G -Xmx8G -XX:+UseZGC -XX:+AlwaysPreTouch";
        serverProperties = {
          motd = "The Silly World :3";
          difficulty = "normal";
          allow-flight = true;
          pvp = false;
          max-players = 4;
          view-distance = 32;
          simulation-distance = 12;
        };
        files."config/plasmovoice/server/config.toml".value = {
          server_id = "73a034c8-70ab-4668-b789-c172e01b81d3";
          host.port = 25566;
        };
        symlinks = {
          "server-icon.png" = ./server-icon.png;
          mods = pkgs.linkFarmFromDrvs "mods" (
            lib.mapAttrsToList (_: pkgs.fetchurl) (lib.importJSON ./mods.json)
          );
        };
      };
    };
  };
}
