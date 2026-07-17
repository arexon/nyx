let
  name = "arexon";
  email = "me@arexon.dev";
  publicSshKey = builtins.readFile ./public-ssh-key.pub;
in {
  flake.modules.nixos.arexon = {
    username = name;
    users.users.arexon = {
      isNormalUser = true;
      extraGroups = ["wheel"];
      openssh.authorizedKeys.keys = [publicSshKey];
    };
  };

  flake.modules.darwin.arexon = {
    username = name;
    system.primaryUser = name;
    users.users.${name} = {
      name = name;
      home = "/Users/${name}";
    };
  };

  flake.modules.homeManager.arexon = {
    programs.git = {
      settings.user = {inherit name email;};
      signing.key = publicSshKey;
    };
  };
}
