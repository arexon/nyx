{
  flake.modules.nixos.shell = {pkgs, ...}: {
    users.defaultUserShell = pkgs.fish;

    programs.fish.enable = true;
  };

  flake.modules.homeManager.shell = {
    home.shell.enableFishIntegration = true;
  };
}
