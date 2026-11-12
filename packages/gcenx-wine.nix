{
  lib,
  stdenvNoCC,
  fetchurl,
}:
stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "gcenx-wine";
  version = "11.0_1";

  src = fetchurl {
    url = "https://github.com/Gcenx/macOS_Wine_builds/releases/download/${finalAttrs.version}/wine-stable-${finalAttrs.version}-osx64.tar.xz";
    hash = "sha256-tQ3FDsf0HVixFaa2hdTRMVujx5e9OqD0khPycDy4I4g=";
  };

  sourceRoot = ".";

  dontConfigure = true;
  dontBuild = true;
  # Fixup would rewrite the signed Mach-O binaries in the app bundle.
  dontFixup = true;

  installPhase = ''
    runHook preInstall

    mkdir -p "$out/Applications" "$out/bin"
    cp -R "Wine Stable.app" "$out/Applications/"

    for f in "$out/Applications/Wine Stable.app/Contents/Resources/wine/bin/"*; do
      ln -s "$f" "$out/bin/$(basename "$f")"
    done

    runHook postInstall
  '';

  meta = {
    description = "Wine for macOS, prebuilt by Gcenx";
    homepage = "https://github.com/Gcenx/macOS_Wine_builds";
    license = lib.licenses.lgpl21Plus;
    sourceProvenance = [lib.sourceTypes.binaryNativeCode];
    platforms = ["aarch64-darwin"];
    mainProgram = "wine";
  };
})
