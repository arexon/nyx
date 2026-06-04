{
  flake-file.inputs = {
    spicetify = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  flake.modules.homeManager.gui = {
    inputs,
    pkgs,
    ...
  }: let
    spicePkgs = inputs.spicetify.legacyPackages.${pkgs.stdenv.hostPlatform.system};

    spotify = pkgs.spotify.overrideAttrs {
      postFixup = ''
        substituteInPlace $out/share/applications/spotify.desktop \
          --replace-fail "Exec=spotify %U" "Exec=env -u DISPLAY spotify %U"
      '';
    };
  in {
    imports = [
      inputs.spicetify.homeManagerModules.spicetify
    ];

    programs.spicetify = {
      enable = true;
      spotifyPackage = spotify;
      wayland = true;
      enabledExtensions = with spicePkgs.extensions; [shuffle];
    };

    programs.niri.settings = {
      window-rules = [
        {
          matches = [{app-id = "spotify";}];
          open-on-workspace = "III";
          default-column-width.proportion = 0.4;
        }
      ];
    };
  };
}
