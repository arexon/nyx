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
    lib,
    ...
  }: let
    inherit (pkgs.stdenv.hostPlatform) isLinux isDarwin system;
    spicePkgs = inputs.spicetify.legacyPackages.${system};

    spotify =
      if isLinux
      then
        pkgs.spotify.overrideAttrs {
          postFixup = ''
            substituteInPlace $out/share/applications/spotify.desktop \
              --replace-fail "Exec=spotify %U" "Exec=env -u DISPLAY spotify %U"
          '';
        }
      else pkgs.spotify;
  in {
    imports = [inputs.spicetify.homeManagerModules.spicetify];

    stylix.targets.spicetify.enable = false;

    programs.spicetify =
      {
        enable = true;
        spotifyPackage = spotify;
        enabledExtensions = with spicePkgs.extensions; [
          shuffle
          fullAlbumDate
          catJamSynced
        ];
        theme = spicePkgs.themes.catppuccin;
        colorScheme = "mocha";
      }
      // (lib.optionalAttrs isLinux {
        wayland = true;
      });

    # <https://github.com/NixOS/nixpkgs/issues/404502#issuecomment-3304356653>
    home.activation.disableSpotifyUpdates =
      lib.mkIf isDarwin
      (lib.hm.dag.entryAfter ["writeBoundary"] ''
        SPOTIFY_UPDATE_DIR=~/Library/Application\ Support/Spotify/PersistentCache/Update
        if ! /usr/bin/stat -f "%Sf" "$SPOTIFY_UPDATE_DIR" 2> /dev/null | grep -q uchg; then
          rm -rf "$SPOTIFY_UPDATE_DIR"
          mkdir -p "$SPOTIFY_UPDATE_DIR"
          /usr/bin/chflags uchg "$SPOTIFY_UPDATE_DIR"
        fi
      '');
  };
}
