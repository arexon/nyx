{
  flake.modules.nixos.shell = {pkgs, ...}: {
    users.defaultUserShell = pkgs.fish;

    programs.fish.enable = true;
  };

  flake.modules.darwin.shell = {
    pkgs,
    config,
    ...
  }: {
    programs.fish.enable = true;
    environment.shells = [pkgs.fish];
    users.users.${config.username}.shell = pkgs.fish;
    homebrew.enableFishIntegration = true;
  };

  flake.modules.homeManager.shell = {
    home.shell.enableFishIntegration = true;
  };
}
