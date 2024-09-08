_: prev: {
  serpl = with prev;
    rustPlatform.buildRustPackage rec {
      pname = "serpl";
      version = "0.3.3";

      src = fetchFromGitHub {
        owner = "yassinebridi";
        repo = "serpl";
        rev = version;
        hash = "sha256-U6fcpFe95rM3GXu7OJhhGkpV1yQNUukqRpGeOtd8UhU=";
      };

      nativeBuildInputs = [makeWrapper];

      cargoHash = "sha256-4cVk1BesBKTtnSRYY0dp5Jtn1c/l0NoB3Hh1iYFKNIc=";

      postFixup = ''
        # Serpl needs ripgrep to function properly.
        wrapProgram $out/bin/serpl \
          --prefix PATH : "${lib.strings.makeBinPath [ripgrep]}"
      '';
    };
}
