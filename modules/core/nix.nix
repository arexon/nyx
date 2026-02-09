{inputs, ...}: {
  flake.modules.nixos.core = {
    nixpkgs = {
      config.allowUnfree = true;
      overlays = [inputs.self.overlays.default];
    };

    nix = {
      channel.enable = false;
      gc = {
        automatic = true;
        options = "--delete-older-than 8d";
        dates = "weekly";
      };
      optimise.automatic = true;
      settings = {
        experimental-features = ["nix-command" "flakes" "pipe-operators"];
        max-jobs = "auto";
        use-xdg-base-directories = true;
        http-connections = 128;
        max-substitution-jobs = 128;
        auto-optimise-store = true;
        keep-outputs = true;
        keep-derivations = true;
        warn-dirty = false;
      };
    };
  };

  flake.modules.homeManager.core = {
    pkgs,
    config,
    ...
  }: {
    nixpkgs = {
      config.allowUnfree = true;
      overlays = [inputs.self.overlays.default];
    };

    home.packages = with pkgs; [
      nix-output-monitor
    ];

    programs.nh = {
      enable = true;
      flake = "${config.home.homeDirectory}/projects/nyx";
    };
  };
}
