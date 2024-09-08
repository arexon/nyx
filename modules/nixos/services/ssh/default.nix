{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.nyx.services.ssh;
in {
  options.nyx.services.ssh = {
    enable = mkBoolOpt false "Whether to enable SSH.";
  };

  config = mkIf cfg.enable {
    programs.ssh.startAgent = true;
  };
}
