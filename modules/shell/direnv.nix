{
  flake.modules.homeManager.shell = {
    programs.direnv = {
      enable = true;
      config = {
        whitelist = {
          prefix = ["~/projects"];
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
