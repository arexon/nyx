{
  flake.modules.homeManager.cli = {
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
