{lib}: rec {
  mkOpt = type: default: description:
    lib.mkOption {inherit type default description;};

  mkBoolOpt = mkOpt lib.types.bool;
}
