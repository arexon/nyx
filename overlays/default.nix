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

  livesplit-one = rustPlatform.buildRustPackage rec {
    pname = "livesplit-one";
    version = "0.6.1";

    src = fetchFromGitHub {
      owner = "AlexKnauth";
      repo = "livesplit-one-druid";
      tag = version;
      hash = "sha256-kbLrlZnI0C8WcBAaA0T4tkk8wT6uoLNo4ZavhIY+T6o=";
    };

    postInstall = let
      icon = fetchurl {
        url = "https://raw.githubusercontent.com/LiveSplit/LiveSplitOne/c39dbe175157145da4d59bfa9b5a8c1f444667d9/src/assets/icon.svg";
        hash = "sha256-mGx4tUUyJKFUJhs9sgS5/0PaK9/LS0mQ2jFyREcEymc=";
      };
      desktopItem = makeDesktopItem {
        name = pname;
        exec = "${pname} %U";
        icon = pname;
        desktopName = "Livesplit One";
        comment = "A sleek, highly customizable timer for speedrunners";
        categories = ["Game"];
      };
    in ''
      for i in 16 24 48 64 96 128 256 512; do
        mkdir -p $out/share/icons/hicolor/''${i}x''${i}/apps
        magick ${icon} -background none -resize ''${i}x''${i} $out/share/icons/hicolor/''${i}x''${i}/apps/${pname}.png
      done
      ln -s ${desktopItem}/share/applications $out/share
    '';

    cargoHash = "sha256-+jSkGgisI7+Ikz/663KapzNYRiSD1q54OG86Gr9aguc=";

    nativeBuildInputs = [
      pkg-config
      wrapGAppsHook3
      imagemagick
    ];

    buildInputs = [
      glib
      pango
      gtk3
    ];
  };
}
