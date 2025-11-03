{config, ...}: {
  programs = {
    nushell = {
      enable = true;
      configFile.source = ./config.nu;
      extraLogin = ''
        printf '\e[H\ec\e[100B'
        ^fastfetch
      '';
      environmentVariables = config.home.sessionVariables;
    };
    carapace = {
      enable = true;
      enableNushellIntegration = false;
    };
  };
}
