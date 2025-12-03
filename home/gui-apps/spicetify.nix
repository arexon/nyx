{
  inputs,
  pkgs,
  ...
}: let
  spicePkgs = inputs.spicetify.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in {
  programs.spicetify = {
    enable = true;
    wayland = true;
    enabledExtensions = with spicePkgs.extensions; [shuffle];
  };
}
