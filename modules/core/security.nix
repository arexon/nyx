{
  flake.modules.nixos.core = {
    security.doas = {
      enable = true;
      extraRules = [
        {
          groups = ["wheel"];
          noPass = true;
          keepEnv = true;
        }
      ];
    };
  };
}
