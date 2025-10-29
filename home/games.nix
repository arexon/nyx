{pkgs, ...}: {
  home.packages = with pkgs; [
    mangohud
    prismlauncher
    mcpelauncher-ui-qt
  ];

  xdg.desktopEntries.minecraft = {
    name = "Minecraft Bedrock";
    icon = "minecraft";
    exec = "mcpelauncher-ui-qt -p";
    categories = ["Application" "Game"];
  };
}
