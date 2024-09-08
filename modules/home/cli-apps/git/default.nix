{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.nyx.cli-apps.git;

  gitignore = "git/.gitignore";
in {
  options.nyx.cli-apps.git = {
    enable = mkBoolOpt false "Whether to enable git support.";
  };

  config = mkIf cfg.enable {
    xdg.configFile.${gitignore}.text = ''
      playground/
    '';

    programs.git = {
      enable = true;
      userName = config.nyx.user.name;
      userEmail = config.nyx.user.email;
      aliases = {
        aa = "add .";
        ap = "add --patch";
        cm = "commit -m";
        ca = "commit --amend";
        uncommit = "reset --soft HEAD^";
        s = "status";
        lol = "log --graph --decorate --pretty=oneline --abbrev-commit";
        lola = "log --graph --decorate --pretty=oneline --abbrev-commit --all";
      };
      extraConfig = {
        init.defaultBranch = "main";
        core.excludesFile = "${config.xdg.configHome}/${gitignore}";
      };
    };
  };
}
