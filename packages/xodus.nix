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
    rev = "1eefc6dc659add0b427f8793e312e32f32cbb8dc";
    hash = "sha256-CkOqMZgJM0QF2btsM+CjlKRk/8v4rU65a6kccFMgEEM=";
  };

  cargoHash = "sha256-c3Nx8GoiAkzo5ob4t3mSJ98CZZvj5w5MTTc5kbVWnc8=";

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
