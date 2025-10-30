{
  programs = {
    nushell = {
      enable = true;
      configFile.source = ./config.nu;
      extraLogin = ''
        printf '\e[H\ec\e[100B'
        ^fastfetch
      '';
    };
    carapace = {
      enable = true;
      enableNushellIntegration = false;
    };
  };
}
