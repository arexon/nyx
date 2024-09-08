{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.nyx.cli-apps.lazygit;
in {
  options.nyx.cli-apps.lazygit = {
    enable = mkBoolOpt false "Whether to enable Lazygit.";
  };

  config = mkIf cfg.enable {
    programs.lazygit = {
      enable = true;
    };
  };
}
