{
  proton-ge-bin,
  fetchzip,
}:
proton-ge-bin.overrideAttrs {
  src = fetchzip {
    url = "https://github.com/Weather-OS/GDK-Proton/releases/download/release10-32/GDK-Proton10-32.tar.gz";
    hash = "sha256-x6LuikI5/hdl6+Y0llTYLDJbX+flma1wJSrJYHxyYQ0=";
  };

  preFixup = ''
    substituteInPlace "$steamcompattool/compatibilitytool.vdf" \
      --replace-fail "GE-Proton10-32" "GDK-Proton"
  '';
}
