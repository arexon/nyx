{
  inputs,
  pkgs,
  ...
}: let
  spicePkgs = inputs.spicetify.legacyPackages.${pkgs.system};
in {
  programs.spicetify = {
    enable = true;
    wayland = true;
    enabledExtensions = with spicePkgs.extensions; [shuffle];
  };
}
