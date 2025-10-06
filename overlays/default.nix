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
}
