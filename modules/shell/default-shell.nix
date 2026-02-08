{
  flake.modules.nixos.shell = {pkgs, ...}: {
    users.defaultUserShell = pkgs.fish;

    programs.fish.enable = true;
  };
}
