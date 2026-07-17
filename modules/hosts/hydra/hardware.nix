{
  flake.modules.darwin."hosts/hydra" = {lib, ...}: {
    nixpkgs.hostPlatform = lib.mkDefault "aarch64-darwin";
  };
}
