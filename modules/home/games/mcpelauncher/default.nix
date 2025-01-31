{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.nyx.games.mcpelauncher;
in {
  options.nyx.games.mcpelauncher = {
    enable = mkBoolOpt false "Whether to install Minecraft Bedrock Launcher.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      mcpelauncher-ui-qt
      mcpelauncher-client
    ];

    xdg.desktopEntries.minecraft = {
      name = "Minecraft";
      exec = "mcpelauncher-ui-qt -p";
      icon = "minecraft";
      categories = ["Game"];
    };
  };
}
