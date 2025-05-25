{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.nyx.services.kanata;
in {
  options.nyx.services.kanata = {
    enable = mkBoolOpt false "Whether to enable kanata.";
  };

  config = mkIf cfg.enable {
    services.kanata = {
      enable = true;
      keyboards."default".config = ''
        (defsrc rctrl h j k l)
        (defalias rctrl (tap-hold 200 200 rctrl (layer-while-held arrows)))
        (deflayer base   @rctrl   h    j    k    l)
        (deflayer arrows _    left   down up right)
      '';
    };
  };
}
