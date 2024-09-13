{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.nyx.tools.direnv;
in {
  options.nyx.tools.direnv = {
    enable = mkBoolOpt false "Whether to enable direnv support.";
  };

  config = mkIf cfg.enable {
    programs.direnv = {
      enable = true;
      config = {
        whitelist = {
          prefix = ["~/projects"];
          exact = ["~/nyx"];
        };
        global = {
          hide_env_diff = true;
          warn_timeout = "0s";
        };
      };
      nix-direnv.enable = true;
    };
  };
}
