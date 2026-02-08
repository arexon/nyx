{
  fetchzip,
  stdenvNoCC,
}:
stdenvNoCC.mkDerivation rec {
  pname = "wezterm-types";
  version = "1.4.0-1";
  src = fetchzip {
    url = "https://github.com/DrKJeff16/wezterm-types/releases/download/v${version}/wezterm-types.zip";
    hash = "sha256-xr/b6n0Ld7i6OR+CsWoqmSvjgr0fP6XHEIzUVfRaxR8=";
  };
  installPhase = ''
    mkdir -p $out
    cp -r $src/* $out
  '';
}
