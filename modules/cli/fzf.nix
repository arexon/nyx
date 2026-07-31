{
  flake.modules.homeManager.cli = {
    stylix.targets.fzf.enable = true;

    programs.fzf = {
      enable = true;
      defaultOptions = [
        "--prompt '-> '"
        "--pointer ':>'"
        "--info 'inline-right'"
      ];
    };
  };
}
