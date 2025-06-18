{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.nyx.games.mangohud;
in {
  options.nyx.games.mangohud = {
    enable = mkBoolOpt false "Whether to enable MangoHud.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [mangohud];
  };
}
