{
  flake.modules.homeManager.wayland-env = {lib, ...}: {
    home.sessionVariables = {
      NIXOS_OZONE_WL = "1";
      QT_QPA_PLATFORMTHEME = lib.mkForce "gtk3";
    };
  };
}
