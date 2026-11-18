{
  flake.modules.homeManager.cli = {
    lib,
    pkgs,
    ...
  }: {
    home.packages = with pkgs;
      [
        aria2
        file
        _7zz
        unar
        wget
        ripgrep
        repgrep
        tokei
        ast-grep
        hyperfine
        ffmpeg-headless
        dust
        timewarrior
        gh
        fd
        tree
        jq
        yt-dlp
        uv
        tmux
        watchexec
      ]
      ++ lib.optionals pkgs.stdenv.hostPlatform.isDarwin [
        mole-cleaner
      ];
  };
}
