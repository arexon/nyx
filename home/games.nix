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

        let id = job spawn { wine ~/games/minecraft-gdk/Minecraft.Windows.exe }
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
