{
  perSystem = {pkgs, ...}: {
    formatter = pkgs.alejandra;
  };
  flake-file.formatter = {pkgs, ...}: pkgs.alejandra;
}
