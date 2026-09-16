{
  lib,
  stdenv,
  rustPlatform,
  fetchFromGitHub,
  pkg-config,
  protobuf,
  openssl,
  webkitgtk_4_1,
  gtk3,
  libsoup_3,
  glib,
  cairo,
  pango,
  gdk-pixbuf,
  atk,
  wrapGAppsHook3,
  cmake,
}:
rustPlatform.buildRustPackage {
  pname = "xodus";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "xodus-gaming";
    repo = "xodus";
    rev = "0670e25aeb0e0e9f800f8f2f4968ae3b681842a7";
    hash = "sha256-ikjCbdXijLWAd7QyE7j8fbd4Pu8yTT/CfJK4K3EQ1rw=";
  };

  cargoHash = "sha256-3vmcmS0XbKfK7H6sZyHpV9NW1CfkI/QjfoIUO82Anqc=";

  nativeBuildInputs =
    [
      pkg-config
      protobuf
      cmake
    ]
    ++ lib.optionals stdenv.hostPlatform.isLinux [
      wrapGAppsHook3
    ];

  buildInputs =
    [
      openssl
    ]
    ++ lib.optionals stdenv.hostPlatform.isLinux [
      webkitgtk_4_1
      gtk3
      libsoup_3
      glib
      cairo
      pango
      gdk-pixbuf
      atk
    ];
}
