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
        (defsrc ralt h j k l)
        (defalias ralt (tap-hold 200 200 ralt (layer-while-held arrows)))
        (deflayer base   @ralt   h    j    k    l)
        (deflayer arrows _    left   down up right)
      '';
    };
  };
}
