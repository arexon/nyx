{
  flake.modules.homeManager.environment = {lib, ...}: {
    home.sessionVariables = {
      NIXOS_OZONE_WL = "1";
      QT_QPA_PLATFORMTHEME = lib.mkForce "gtk3";
    };
  };
}
