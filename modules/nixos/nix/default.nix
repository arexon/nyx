{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.nyx.nix;
in {
  options.nyx.nix = {
    enable = mkBoolOpt false "Whether to manage nix configuration.";
  };

  config = mkIf cfg.enable {
    nix = {
      settings = {
        experimental-features = ["nix-command" "flakes"];
        auto-optimise-store = true;
        substituters = ["https://helix.cachix.org"];
        trusted-public-keys = ["helix.cachix.org-1:ejp9KQpR1FBI2onstMQ34yogDm4OgU2ru6lIwPvuCVs="];
      };
      gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 30d";
      };
    };

    documentation.enable = false;

    programs.nh = {
      enable = true;
      flake = "/home/${config.nyx.user.name}/nyx";
    };

    environment.systemPackages = with pkgs; [
      nix-output-monitor
    ];
  };
}
