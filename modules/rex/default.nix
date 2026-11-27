{inputs, ...}: let
  tailscaleLogin = "tailscale:arexon@github";
in {
  flake-file.inputs = {
    rex = {
      url = "https://pkgs.superlogical.com/rex/nix/preview.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  flake.modules.nixos.rex = {
    imports = [inputs.rex.nixosModules.default];

    services.rex.loginServer = {
      enable = true;
      tailscaleServe.enable = true;
      accounts.arexon.principals = [tailscaleLogin];
      defaults.${tailscaleLogin} = "arexon";
    };
  };

  # The NixOS module adds the ssh guard to /etc/ssh/ssh_config. nix-darwin has no Rex
  # module, so add the guard to the system ssh config here.
  flake.modules.darwin.rex = {pkgs, ...}: {
    programs.ssh.extraConfig = ''
      Include ${inputs.rex.packages.${pkgs.stdenv.hostPlatform.system}.rex}/share/rex/ssh_config.d/50-rex.conf
    '';
  };

  flake.modules.homeManager.rex = {
    imports = [inputs.rex.homeManagerModules.default];

    programs.rex = {
      enable = true;
      sshGuard = false;
    };

    xdg.configFile."rex" = {
      source = ./config;
      recursive = true;
    };
  };
}
