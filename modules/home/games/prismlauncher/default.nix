{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.nyx.games.prismlauncher;
in {
  options.nyx.games.prismlauncher = {
    enable = mkBoolOpt false "Whether to install Prism Launcher.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [prismlauncher];
  };
}
