{
  proton-ge-bin,
  fetchzip,
}:
proton-ge-bin.overrideAttrs {
  src = fetchzip {
    url = "https://github.com/Weather-OS/GDK-Proton/releases/download/release/GE-Proton10-25.tar.gz";
    hash = "sha256-2ShpJjvf0tw+AnjMOwyHllfdxKO6kRGJpackeWOo7iM=";
  };

  preFixup = ''
    substituteInPlace "$steamcompattool/compatibilitytool.vdf" \
      --replace-fail "GE-Proton10-25" "GDK-Proton"
  '';
}
