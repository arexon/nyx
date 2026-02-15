{
  flake.modules.homeManager.gui = {pkgs, ...}: {
    stylix.targets.firefox.enable = false;

    programs.firefox = {
      enable = true;
      nativeMessagingHosts = [pkgs.firefoxpwa];
    };
  };
}
