{self, ...}: {
  flake.modules.nixos.core = self.modules.nixos.sudo;
  flake.modules.nixos.sudo = {
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

  flake.modules.darwin.core = self.modules.darwin.sudo;
  flake.modules.darwin.sudo = {
    security.pam.services.sudo_local = {
      enable = true;
      touchIdAuth = true;
    };
  };
}
