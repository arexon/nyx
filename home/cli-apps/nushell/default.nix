{
  programs = {
    nushell = {
      enable = true;
      configFile.source = ./config.nu;
      extraLogin = ''
        printf '\e[H\ec\e[100B'
      '';
    };
    carapace = {
      enable = true;
      enableNushellIntegration = false;
    };
  };
}
