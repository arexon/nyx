{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.nyx.apps.obsidian;
in {
  options.nyx.apps.obsidian = {
    enable = mkBoolOpt false "Whether to enable Obsidian.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [obsidian];
  };
}
