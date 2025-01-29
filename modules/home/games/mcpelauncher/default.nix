{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.nyx.games.mcpelauncher;

  mcpelauncher-client = pkgs.mcpelauncher-client.overrideAttrs (prev:
    with pkgs; {
      # Remove once <https://github.com/NixOS/nixpkgs/pull/377734> is on `nixos-unstable`.
      postPatch = lib.optionalString stdenv.isLinux ''
        substituteInPlace mcpelauncher-client/src/jni/main_activity.cpp \
          --replace-fail /usr/bin/xdg-open ${xdg-utils}/bin/xdg-open \
          --replace-fail /usr/bin/zenity ${zenity}/bin/zenity

        substituteInPlace file-picker/src/file_picker_zenity.cpp \
          --replace-fail /usr/bin/zenity ${zenity}/bin/zenity
      '';
    });
in {
  options.nyx.games.mcpelauncher = {
    enable = mkBoolOpt false "Whether to install Minecraft Bedrock Launcher.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      (mcpelauncher-ui-qt.overrideAttrs (_: {
        preFixup = ''
          qtWrapperArgs+=(
            --prefix PATH : ${lib.makeBinPath [mcpelauncher-client]}
            --unset QT_STYLE_OVERRIDE
          )
        '';
      }))
      mcpelauncher-client
    ];

    xdg.desktopEntries.minecraft = {
      name = "Minecraft";
      exec = "mcpelauncher-ui-qt -p";
      icon = "minecraft";
      categories = ["Game"];
    };
  };
}
