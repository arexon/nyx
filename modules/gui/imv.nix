{
  flake.modules.homeManager.gui = {config, ...}: {
    programs.imv = {
      enable = true;
      settings.options.background = config.lib.stylix.colors.base01;
    };
  };
}
