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
}:
rustPlatform.buildRustPackage {
  pname = "xodus";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "xodus-gaming";
    repo = "xodus";
    rev = "4615749c6e02cc3b9acce2abbe9916fe8c376f9a";
    hash = "sha256-4BNbNANSsKpiCVLYM8TPWpykum4RQ/cNmsHhiax6pdA=";
  };

  cargoHash = "sha256-VenzKiQlyNGsT3bS4wuZmpbEm9KL3dv5JeVtngoZeec=";

  nativeBuildInputs =
    [
      pkg-config
      protobuf
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
