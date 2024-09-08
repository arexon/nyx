{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.nyx.desktop.wallpapers;

  wallpapers = builtins.attrNames (builtins.readDir ./images);

  mkPicturesPath = filename: "Pictures/wallpapers/${filename}";
in {
  options.nyx.desktop.wallpapers = with types; {
    enable = mkBoolOpt false "Whether to add wallpapers to ~/Pictures/wallpapers.";
    list = mkOpt (attrsOf str) [] "The list of all wallpapers.";
  };

  config = mkIf cfg.enable {
    nyx.desktop.wallpapers.list = builtins.listToAttrs (builtins.map (filename: {
        name = lib.head (lib.splitString "." filename);
        value = mkPicturesPath filename;
      })
      wallpapers);

    home.file =
      lib.foldl (
        acc: filename:
          acc // {${mkPicturesPath filename}.source = ./images + "/${filename}";}
      ) {}
      wallpapers;
  };
}
