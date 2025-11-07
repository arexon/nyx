{
  pkgs,
  lib,
  ...
}: let
  inherit (lib) getExe;
in {
  home.packages = with pkgs; [
    mangohud
    prismlauncher
    mcpelauncher-ui-qt
    wine
  ];

  xdg.desktopEntries.minecraft = {
    name = "Minecraft Bedrock";
    icon = "minecraft";
    exec = "mcpelauncher-ui-qt -p";
    categories = ["Application" "Game"];
  };

  xdg.desktopEntries.minecraft-gdk = let
    run-mc-gdk = pkgs.writeTextFile rec {
      name = "run-mc-gdk";
      destination = "/bin/${name}";
      executable = true;
      text = ''
        #!/usr/bin/env nu

        let current = open ~/games/minecraft/current | str trim
        let path = [$env.HOME games minecraft $current Minecraft.Windows.Exe] | path join
        let id = job spawn { wine $path }
        sleep 1sec
        while not (niri msg --json windows | from json | where app_id == "minecraft.windows.exe" | is-empty) { sleep 2sec }
        job kill $id
      '';
    };
  in {
    name = "Minecraft Bedrock for Windows";
    icon = "minecraft";
    exec = getExe run-mc-gdk;
    categories = ["Application" "Game"];
  };
}
