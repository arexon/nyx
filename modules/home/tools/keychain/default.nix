{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.nyx.tools.keychain;
in {
  options.nyx.tools.keychain = {
    enable = mkBoolOpt false "Whether to enable keychain support.";
  };

  config = mkIf cfg.enable {
    programs.keychain = {
      enable = true;
      keys = ["id_ed25519"];
    };
  };
}
