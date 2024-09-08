{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.nyx.user;
in {
  options.nyx.user = with types; {
    name = mkOpt str "flux" "The name to use for the user account.";
  };

  config = {
    users.users.${cfg.name} = {
      isNormalUser = true;
      shell = pkgs.nushell;
      extraGroups = ["wheel"];
    };
  };
}
