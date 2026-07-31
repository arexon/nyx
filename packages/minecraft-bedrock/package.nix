{
  lib,
  stdenvNoCC,
  writeShellScript,
  writeText,
  libicns,
  imagemagick,
}: let
  inherit (lib.generators) toPlist;

  launcher = writeShellScript "MinecraftBedrock" ''
    set -euo pipefail

    support="$HOME/Library/Application Support/Minecraft Bedrock"
    wine="$support/wine/bin/wine"
    exe="$support/game/Minecraft.Windows.exe"
    export WINEPREFIX="$support/prefix"

    if [[ ! -x "$wine" ]]; then
      echo "Minecraft Bedrock: missing wine at $wine" >&2
      exit 1
    fi

    if [[ ! -f "$exe" ]]; then
      echo "Minecraft Bedrock: missing game at $exe" >&2
      exit 1
    fi

    "$wine" "$exe" "$@"
  '';

  infoPlist = writeText "Info.plist" (toPlist {escape = true;} {
    CFBundleExecutable = "MinecraftBedrock";
    CFBundleIconFile = "AppIcon";
    CFBundleIdentifier = "app.minecraft-bedrock";
    CFBundleName = "Minecraft Bedrock";
    CFBundlePackageType = "APPL";
    CFBundleShortVersionString = "0.1.0";
    CFBundleVersion = "0.1.0";
    LSMinimumSystemVersion = "14.0";
  });
in
  stdenvNoCC.mkDerivation {
    pname = "minecraft-bedrock";
    version = "0.1.0";

    src = ./.;

    nativeBuildInputs = [libicns imagemagick];

    dontConfigure = true;
    dontBuild = true;

    installPhase = ''
      runHook preInstall

      app="$out/Applications/Minecraft Bedrock.app/Contents"
      mkdir -p "$app/MacOS" "$app/Resources"
      cp ${launcher} "$app/MacOS/MinecraftBedrock"
      chmod +x "$app/MacOS/MinecraftBedrock"
      cp ${infoPlist} "$app/Info.plist"

      magick icon.png -background none -flatten PNG32:icon-rgba.png
      for size in 16 32 128 256 512; do
        magick icon-rgba.png -resize ''${size}x''${size} icon-$size.png
      done
      png2icns "$app/Resources/AppIcon.icns" \
        icon-16.png icon-32.png icon-128.png icon-256.png icon-512.png

      runHook postInstall
    '';

    meta = {
      description = "Thin launcher for Minecraft Bedrock (Wine) on macOS";
      platforms = lib.platforms.darwin;
    };
  }
