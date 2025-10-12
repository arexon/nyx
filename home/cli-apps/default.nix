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
    ./keychain.nix
    ./imv.nix
  ];

  home.packages = with pkgs; [
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
  ];
}
