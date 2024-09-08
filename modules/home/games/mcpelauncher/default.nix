{
  config,
  lib,
  inputs,
  ...
}:
with lib; let
  cfg = config.nyx.games.mcpelauncher;
in {
  imports = [inputs.nix-flatpak.homeManagerModules.nix-flatpak];

  options.nyx.games.mcpelauncher = {
    enable = mkBoolOpt false "Whether to install Minecraft Bedrock Launcher.";
  };

  config = mkIf cfg.enable {
    services.flatpak.packages = ["io.mrarm.mcpelauncher"];

    xdg.desktopEntries.minecraft = {
      name = "Minecraft";
      exec = ''
        flatpak run --command=mcpelauncher-ui-qt io.mrarm.mcpelauncher -p
      '';
      icon = "minecraft";
      categories = ["Game"];
    };
  };
}
