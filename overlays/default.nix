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
}
