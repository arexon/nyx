{pkgs, ...}: {
  imports = [
    ./nushell
    ./helix.nix
    ./git.nix
    ./lazygit.nix
    ./starship.nix
    ./fzf.nix
    ./btop.nix
    ./yazi.nix
    ./bat.nix
    ./direnv.nix
    ./imv.nix
    ./television.nix
    ./fastfetch
  ];

  home.packages = with pkgs; [
    file
    wget
    p7zip
    _7zz
    rar
    tldr
    ripgrep
    repgrep
    cloc
    ast-grep
    hyperfine
    ffmpeg
    dust
    timewarrior
    git-filter-repo
    gh
    wl-clipboard
    playerctl
    fd
    nix-prefetch-github
  ];
}
