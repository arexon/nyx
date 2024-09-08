{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.nyx.user;
in {
  options.nyx.user = with types; {
    name = mkOpt str "flux" "The name to use for the user account.";
    email = mkOpt str "flux@example.com" "The email to associate with the user.";
  };

  config = {
    home = {
      username = cfg.name;
      homeDirectory = "/home/${cfg.name}";
    };
  };
}
