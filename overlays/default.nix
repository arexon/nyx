{...}: _: super:
with super; {
  spotify = spotify.overrideAttrs {
    postFixup = ''
      substituteInPlace $out/share/applications/spotify.desktop \
        --replace-fail "Exec=spotify %U" "Exec=env NIXOS_OZONE_WL= spotify %U"
    '';
  };

  btop = btop.override {
    rocmSupport = true;
  };

  color-lsp = rustPlatform.buildRustPackage rec {
    pname = "color-lsp";
    version = "0.2.0";

    src = fetchFromGitHub {
      owner = "huacnlee";
      repo = "color-lsp";
      tag = "v${version}";
      hash = "sha256-m26eIA+K5ERmmlDaX6gJp+ABL4bLnsQF/R8A+tzmpZw=";
    };

    cargoHash = "sha256-RUQmjM/DLBrsvn9/1BnP0V7VduP4UHrmnPiqUhzFimo=";

    meta.mainProgram = pname;
  };

  proton-gdk-bin = proton-ge-bin.overrideAttrs {
    src = fetchzip {
      url = "https://github.com/Weather-OS/GDK-Proton/releases/download/release/GE-Proton10-25.tar.gz";
      hash = "sha256-2ShpJjvf0tw+AnjMOwyHllfdxKO6kRGJpackeWOo7iM=";
    };

    preFixup = ''
      substituteInPlace "$steamcompattool/compatibilitytool.vdf" \
        --replace-fail "GE-Proton10-25" "GDK-Proton"
    '';
  };
}
