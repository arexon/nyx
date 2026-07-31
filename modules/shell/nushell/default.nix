{
  flake.modules.homeManager.shell = {config, ...}: {
    stylix.targets.nushell.enable = true;

    programs = {
      nushell = {
        enable = true;
        configFile.source = ./config.nu;
        extraLogin = ''
          if (is-terminal --stdin) {
            printf '\e[H\ec\e[100B'
            ^fastfetch
          }
        '';
        environmentVariables = config.home.sessionVariables;
      };
      carapace = {
        enable = true;
        enableNushellIntegration = false;
      };
    };
  };
}
