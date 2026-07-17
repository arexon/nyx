{
  flake.modules.homeManager.cli = {
    lib,
    pkgs,
    ...
  }: {
    home.packages = with pkgs;
      [
        file
        _7zz
        unar
        wget
        ripgrep
        repgrep
        cloc
        ast-grep
        hyperfine
        ffmpeg
        dust
        timewarrior
        gh
        fd
        tree
        jq
        calc
        yt-dlp
        opencode
        xodus
      ]
      ++ lib.optionals pkgs.stdenv.hostPlatform.isDarwin [
        mole-cleaner
      ];
  };
}
