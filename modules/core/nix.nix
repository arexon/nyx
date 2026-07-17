{inputs, ...}: let
  common = {
    nixpkgs = {
      config.allowUnfree = true;
      overlays = [inputs.self.overlays.default];
    };
    nix = {
      channel.enable = false;
      optimise.automatic = true;
      settings = {
        experimental-features = ["nix-command" "flakes" "pipe-operators"];
        trusted-users = ["@wheel" "@admin"];
        auto-optimise-store = true;
      };
      gc = {
        automatic = true;
        options = "--delete-older-than 8d";
      };
    };
  };
in {
  flake.modules.nixos.core = {
    imports = [common];
    nix.gc.dates = "weekly";
  };

  flake.modules.darwin.core = {
    imports = [common];
    nix.gc.interval.Weekday = 0;
  };

  flake.modules.homeManager.core = {
    pkgs,
    config,
    ...
  }: {
    home.packages = with pkgs; [
      nixd
      alejandra
      nix-output-monitor
    ];

    programs.nh = {
      enable = true;
      flake = "${config.home.homeDirectory}/Projects/nyx";
    };

    # Darwin has no man-db package; cache gen only warns.
    programs.man.generateCaches = !pkgs.stdenv.hostPlatform.isDarwin;
  };
}
