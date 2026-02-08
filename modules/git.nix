let
  gitignore = "git/.gitignore";
in {
  flake.modules.homeManager.git = {config, ...}: {
    xdg.configFile.${gitignore}.text = ''
      playground/
      dev.nu
    '';

    programs.git = {
      enable = true;
      settings = {
        alias = {
          aa = "add .";
          ap = "add --patch";
          cm = "commit -m";
          ca = "commit --amend";
          uncommit = "reset --soft HEAD^";
          s = "status";
          lol = "log --graph --decorate --pretty=oneline --abbrev-commit";
          lola = "log --graph --decorate --pretty=oneline --abbrev-commit --all";
        };
        init.defaultBranch = "main";
        gpg = {
          format = "ssh";
          ssh.allowedSignersFile = "~/.config/git/allowed_signers";
        };
        core.excludesFile = "${config.xdg.configHome}/${gitignore}";
        column.ui = "auto";
        branch.sort = "-committerdate";
        pull.rebase = true;
        diff = {
          colorMoved = "plain";
          mnemonicPrefix = true;
          renames = true;
          algorithm = "histogram";
        };
        fetch = {
          prune = true;
          all = true;
        };
        rebase = {
          autoStash = true;
          updateRefs = true;
        };
        rerere = {
          enabled = true;
          autoupdate = true;
        };
      };
      signing.signByDefault = true;
    };
  };
}
