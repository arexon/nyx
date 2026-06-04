{
  flake.modules.homeManager.gui = {
    pkgs,
    config,
    ...
  }: {
    # TODO: Remove this
    nixpkgs.config.permittedInsecurePackages = ["electron-39.8.10"];

    home.packages = [pkgs.unstable.bitwarden-desktop];
    home.sessionVariables = {
      SSH_AUTH_SOCK = "${config.home.homeDirectory}/.bitwarden-ssh-agent.sock";
    };

    programs.niri.settings = {
      spawn-at-startup = [
        {command = ["bitwarden"];}
      ];

      window-rules = [
        {
          matches = [{app-id = "Bitwarden";}];
          open-floating = true;
        }
      ];
    };
  };
}
