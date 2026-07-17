{
  flake.modules.nixos.core = {lib, ...}: {
    options.username = lib.mkOption {
      type = lib.types.str;
    };
  };

  flake.modules.darwin.core = {lib, ...}: {
    options.username = lib.mkOption {
      type = lib.types.str;
    };
  };
}
