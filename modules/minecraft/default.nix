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
          max-players = 4;
          view-distance = 24;
          simulation-distance = 12;
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
