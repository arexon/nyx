{pkgs, ...}: {
  home.packages = with pkgs; [
    mangohud
    prismlauncher
    mcpelauncher-ui-qt
  ];
}
