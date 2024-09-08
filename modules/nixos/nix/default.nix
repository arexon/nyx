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
