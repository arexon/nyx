{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
with lib; let
  cfg = config.nyx.apps.spotify;
in {
  imports = [
    inputs.spicetify-nix.homeManagerModules.default
  ];

  options.nyx.apps.spotify = {
    enable = mkBoolOpt false "Whether to enable Spotify.";
  };

  config = mkIf cfg.enable {
    programs.spicetify = let
      spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
    in {
      enable = true;
      enabledExtensions = with spicePkgs.extensions; [
        adblock
        keyboardShortcut
        betterGenres
      ];
      theme = spicePkgs.themes.text;
      colorScheme = "kanagawa";
    };
  };
}
