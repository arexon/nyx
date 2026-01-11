{
  inputs,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    mangohud
    prismlauncher
    pcsx2
    inputs.hytale-launcher.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
