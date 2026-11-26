{
  lib,
  fetchurl,
  stdenvNoCC,
  undmg,
}:
stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "levilauncher";
  version = "1.2.0-beta.2";

  src = fetchurl {
    url = "https://github.com/LiteLDev/LeviLauncher/releases/download/v${finalAttrs.version}/LeviLauncher-macos-arm64-installer.dmg";
    hash = "sha256-gmJnKMTIH3ktGQ8dT+L8/zwrb2HVphWaxEp5iNfQcv0=";
  };

  nativeBuildInputs = [undmg];
  sourceRoot = "LeviLauncher.app";

  installPhase = ''
    mkdir -p $out/Applications/LeviLauncher.app
    cp -R . $out/Applications/LeviLauncher.app
  '';

  dontFixup = true;

  meta = {
    description = "Launcher for Minecraft Bedrock Edition with LeviLamina mod support";
    homepage = "https://github.com/LiteLDev/LeviLauncher";
    license = lib.licenses.gpl3Only;
    sourceProvenance = [lib.sourceTypes.binaryNativeCode];
    platforms = ["aarch64-darwin"];
  };
})
