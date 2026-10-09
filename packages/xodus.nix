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
    rev = "64d39eb87a56c7d0d7e7fde0b233654ac5477b0f";
    hash = "sha256-4H8A/nix9ragRy9CBYe4CZapv6pgsY+TZMZjvc7gZSc=";
  };

  cargoHash = "sha256-Dpk8DOXTXpxB0IAf2+d9yLPB0XdS5oa5ESgjTjLO4H4=";

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
