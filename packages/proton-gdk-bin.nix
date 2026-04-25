{
  proton-ge-bin,
  fetchzip,
}:
proton-ge-bin.overrideAttrs {
  src = fetchzip {
    url = "https://github.com/LukasPAH/GDK-Proton-Custom/releases/download/release-10-32-3/GDK-Proton10-32-Custom-3.tar.gz";
    hash = "sha256-cFf9PxZoeLC8sUyde0QOxpR3J7reINgJF06+Guq2qhU=";
  };

  preFixup = ''
    substituteInPlace "$steamcompattool/compatibilitytool.vdf" \
      --replace-fail "GE-Proton10-32" "GDK-Proton"
  '';
}
