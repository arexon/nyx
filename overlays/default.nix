self: super:
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

  obs-studio-plugins =
    obs-studio-plugins
    // {
      input-overlay = obs-studio-plugins.input-overlay.overrideAttrs (old: rec {
        version = "5.1.0";
        src = fetchFromGitHub {
          owner = "univrsal";
          repo = "input-overlay";
          rev = "refs/tags/${version}";
          hash = "sha256-3mH2QWZSZlRkuYikdFl0d3INA4TnSP85/ePTSdnxo+c=";
          fetchSubmodules = true;
        };
        postFixup =
          (old.postFixup or "")
          + ''
            substituteInPlace $out/lib/pkgconfig/uiohook.pc \
              --replace '//nix' '/nix'
          '';
      });
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
  };
}
