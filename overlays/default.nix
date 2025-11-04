_: super:
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

  # Temporary fix for audio from <https://github.com/NixOS/nixpkgs/issues/380493#issuecomment-3456745728>.
  mcpelauncher-client = mcpelauncher-client.overrideAttrs (old: {
    cmakeFlags =
      (builtins.filter (flag: flag != (lib.cmakeBool "USE_SDL3_AUDIO" false)) old.cmakeFlags)
      ++ [(lib.cmakeBool "SDL3_VENDORED" false)];
  });

  wine = wine64.overrideAttrs {
    src = fetchFromGitHub {
      owner = "Weather-OS";
      repo = "WineGDK";
      rev = "1b9bb5d47fa4cb5419ce25a5d9fd6e496930cdd8";
      sha256 = "sha256-1GtRhxDAGVnP2WB+fJ5EZl+HyHcRW8u0YqPQysFRmiE=";
    };
    patches = [];
  };
}
