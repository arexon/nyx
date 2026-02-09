{
  flake.modules.homeManager.cli = {config, ...}: {
    programs.imv = {
      enable = true;
      settings.options.background = config.lib.stylix.colors.base01;
    };
  };
}
