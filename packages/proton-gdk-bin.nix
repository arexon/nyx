{
  proton-ge-bin,
  fetchzip,
}:
proton-ge-bin.overrideAttrs {
  src = fetchzip {
    url = "https://github.com/Weather-OS/GDK-Proton/releases/download/release10-29/GDK-Proton10-29.tar.gz";
    hash = "sha256-MtasTr8lXBY0vQlOPaXU94CO6O//l1qwAqFDbu5os+M=";
  };

  preFixup = ''
    substituteInPlace "$steamcompattool/compatibilitytool.vdf" \
      --replace-fail "GE-Proton10-29" "GDK-Proton"
  '';
}
