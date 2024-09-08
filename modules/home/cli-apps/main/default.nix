{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.nyx.cli-apps.extraPackages;
in {
  options.nyx.cli-apps = with types; {
    extraPackages = mkOpt (listOf package) [] "Extra CLI tools to install.";
  };

  config = {
    home.packages = cfg;
  };
}
