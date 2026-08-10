{
  lib,
  stdenvNoCC,
  writeShellScript,
  writeText,
  libicns,
  imagemagick,
}: let
  inherit (lib.generators) toPlist;

  launcher = writeShellScript "Minecraft" ''
    set -euo pipefail

    support="$HOME/Library/Application Support/Minecraft"
    wine="$support/wine/bin/wine"
    exe="$support/game/Minecraft.Windows.exe"
    export WINEPREFIX="$support/prefix"

    if [[ ! -x "$wine" ]]; then
      echo "Minecraft: missing wine at $wine" >&2
      exit 1
    fi

    if [[ ! -f "$exe" ]]; then
      echo "Minecraft: missing game at $exe" >&2
      exit 1
    fi

    "$wine" "$exe" "$@"
  '';

  infoPlist = writeText "Info.plist" (toPlist {escape = true;} {
    CFBundleExecutable = "Minecraft";
    CFBundleIconFile = "AppIcon";
    CFBundleIdentifier = "app.minecraft";
    CFBundleName = "Minecraft";
    CFBundlePackageType = "APPL";
    CFBundleShortVersionString = "0.1.0";
    CFBundleVersion = "0.1.0";
    LSMinimumSystemVersion = "14.0";
  });
in
  stdenvNoCC.mkDerivation {
    pname = "minecraft";
    version = "0.1.0";

    src = ./.;

    nativeBuildInputs = [libicns imagemagick];

    dontConfigure = true;
    dontBuild = true;

    installPhase = ''
      runHook preInstall

      app="$out/Applications/Minecraft.app/Contents"
      mkdir -p "$app/MacOS" "$app/Resources"
      cp ${launcher} "$app/MacOS/Minecraft"
      chmod +x "$app/MacOS/Minecraft"
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
      description = "Thin launcher for Minecraft (Wine) on macOS";
      platforms = lib.platforms.darwin;
    };
  }
