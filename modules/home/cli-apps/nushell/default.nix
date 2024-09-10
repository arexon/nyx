{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.nyx.cli-apps.nushell;
in {
  options.nyx.cli-apps.nushell = {
    enable = mkBoolOpt false "Whether to enable Nushell.";
  };

  config = mkIf cfg.enable {
    programs = {
      nushell = {
        enable = true;
        configFile.source = ./config.nu;
        extraLogin = ''
          printf '\e[H\ec\e[100B'
        '';
        environmentVariables =
          (builtins.mapAttrs
            (name: value: ''"${builtins.toString value}"'')
            config.home.sessionVariables)
          // {
            # Because Nushell is being a PITA
            FLAKE = "'${config.home.homeDirectory}/projects/nyx'";
          };
      };
      carapace = {
        enable = true;
        enableNushellIntegration = false;
      };
    };
  };
}
