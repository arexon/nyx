{
  config,
  lib,
  inputs,
  system,
  ...
}:
with lib; let
  cfg = config.nyx.cli-apps.gadacz;
in {
  options.nyx.cli-apps.gadacz = {
    enable = mkBoolOpt false "Whether to enable gadacz.";
  };

  config = mkIf cfg.enable {
    home.packages = [inputs.gadacz.packages.${system}.default];
  };
}
