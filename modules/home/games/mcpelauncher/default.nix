{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.nyx.games.mcpelauncher;

  # We must wrap it inside an FHS environment because of zenity. See:
  # <https://github.com/minecraft-linux/file-picker/blob/f5cbac6249e3fafd39959b7ab9714dda7048aa42/src/file_picker_zenity.cpp#L10>
  mcpelauncher-ui-qt-wrapped = pkgs.buildFHSEnv {
    name = "mcpelauncher-ui-qt";
    targetPkgs = pkgs: [pkgs.mcpelauncher-ui-qt pkgs.zenity];
    extraMounts = [
      {
        source = "${pkgs.zenity}/bin/zenity";
        target = "/usr/bin/zenity";
      }
    ];
  };
in {
  options.nyx.games.mcpelauncher = {
    enable = mkBoolOpt false "Whether to install Minecraft Bedrock Launcher.";
  };

  config = mkIf cfg.enable {
    xdg.desktopEntries = {
      minecraft = {
        name = "Minecraft";
        exec = ''${mcpelauncher-ui-qt-wrapped}/bin/mcpelauncher-ui-qt -c "mcpelauncher-ui-qt -p"'';
        icon = "minecraft";
        categories = ["Game"];
      };
      mcpelauncher-ui-qt = {
        name = "Minecraft Bedrock Launcher";
        exec = ''${mcpelauncher-ui-qt-wrapped}/bin/mcpelauncher-ui-qt -c "mcpelauncher-ui-qt"'';
        icon = "mcpelauncher-ui-qt";
        categories = ["Game"];
      };
    };
  };
}
