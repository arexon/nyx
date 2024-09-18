{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.nyx.services.ss-to-r2;

  ss-to-r2 = "${pkgs.ss-to-r2}/bin/ss-to-r2";
in {
  options.nyx.services.ss-to-r2 = {
    enable = mkBoolOpt false "Whether to enable ss-to-r2.";
  };

  config = mkIf cfg.enable {
    systemd.user.services.ss-to-r2 = {
      Unit = {
        Description = "Screenshot and upload files to R2 on Cloudflare";
      };
      Service = {
        Type = "simple";
        ExecStart = ss-to-r2;
        ExecStop = "pkill -f ${ss-to-r2}";
        PassEnvironment = ["PATH"];
      };
      Install = {
        WantedBy = ["default.target"];
      };
    };
  };
}
