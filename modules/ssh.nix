{
  flake.modules.nixos.ssh = {
    services.openssh.enable = true;
  };

  flake.modules.homeManager.ssh = {
    programs.ssh = {
      enable = true;
      enableDefaultConfig = false;
      matchBlocks = {
        "leviathan" = {
          hostname = "leviathan.arexon.dev";
          user = "arexon";
          identityFile = "~/.ssh/id_ed25519";
          extraOptions.PreferredAuthentications = "publickey";
        };
      };
    };
  };
}
