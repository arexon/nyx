{
  flake.modules.nixos.kanata = {
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
