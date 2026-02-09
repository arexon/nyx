let
  name = "arexon";
  email = "me@arexon.dev";
  publicSshKey = builtins.readFile ../../secrets/arexon-public-ssh-key.pub;
in {
  flake.modules.nixos.arexon = {config, ...}: {
    users.users.arexon = {
      isNormalUser = true;
      extraGroups = ["wheel"];
      hashedPasswordFile = config.age.secrets.arexon-password.path;
      openssh.authorizedKeys.keys = [publicSshKey];
    };

    age.secrets = {
      arexon-private-ssh-key = {
        file = ../../secrets/arexon-private-ssh-key.age;
        path = "/home/arexon/.ssh/id_ed25519";
        owner = "arexon";
        mode = "600";
      };
    };
  };

  flake.modules.homeManager.arexon = {
    programs.git = {
      settings.user = {inherit name email;};
      signing.key = publicSshKey;
    };

    home.file = {
      ".ssh/id_ed25519.pub".text = publicSshKey;
    };
  };
}
