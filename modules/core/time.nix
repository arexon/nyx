{
  flake.modules.nixos.core = {
    time.timeZone = "Africa/Cairo";
    i18n.extraLocaleSettings.LC_TIME = "en_US.UTF-8";
  };
}
