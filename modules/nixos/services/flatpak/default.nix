{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.nyx.services.flatpak;
in {
  options.nyx.services.flatpak = {
    enable = mkBoolOpt false "Whether to enable support for Flatpak.";
  };

  config = mkIf cfg.enable {
    services.flatpak.enable = true;
  };
}
