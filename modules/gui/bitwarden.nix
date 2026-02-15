{
  flake.modules.homeManager.gui = {
    pkgs,
    config,
    ...
  }: {
    home.packages = [pkgs.bitwarden-desktop];
    home.sessionVariables = {
      SSH_AUTH_SOCK = "${config.home.homeDirectory}/.bitwarden-ssh-agent.sock";
    };
  };
}
