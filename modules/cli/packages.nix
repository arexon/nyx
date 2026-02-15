{
  flake.modules.homeManager.cli = {pkgs, ...}: {
    home.packages = with pkgs; [
      file
      wget
      p7zip
      _7zz
      rar
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
    ];
  };
}
