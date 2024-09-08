{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.nyx.hardware.storage;
in {
  options.nyx.hardware.storage = {
    enable = mkBoolOpt false "Whether to enable support for extra storage devices.";
  };

  config = mkIf cfg.enable {
    # Because Windows ¯\_(ツ)_/¯
    boot.supportedFilesystems = ["ntfs"];
  };
}
