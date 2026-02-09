{
  flake-file.inputs = {
    spicetify = {
      url = "github:Gerg-L/spicetify-nix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        systems.follows = "systems";
      };
    };
  };

  flake.modules.homeManager.gui = {
    inputs,
    pkgs,
    ...
  }: let
    spice-pkgs = inputs.spicetify.legacyPackages.${pkgs.stdenv.hostPlatform.system};

    spotify = spotify.overrideAttrs {
      postFixup = ''
        substituteInPlace $out/share/applications/spotify.desktop \
          --replace-fail "Exec=spotify %U" "Exec=env NIXOS_OZONE_WL= spotify %U"
      '';
    };
  in {
    imports = [
      inputs.spicetify.homeManagerModules.spicetify
    ];

    programs.spicetify = {
      enable = true;
      wayland = true;
      enabledExtensions = with spice-pkgs.extensions; [shuffle];
    };
  };
}
