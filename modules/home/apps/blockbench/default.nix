{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.nyx.apps.blockbench;
in {
  options.nyx.apps.blockbench = {
    enable = mkBoolOpt false "Whether to enable Blockbench.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [blockbench];
  };
}
