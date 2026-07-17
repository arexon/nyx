{
  flake.modules.darwin.gui = {
    nixpkgs.config.permittedInsecurePackages = ["electron-39.8.10"];

    homebrew.casks = [
      "protonvpn"
      "bitwarden"
      "obs"
      "scroll-reverser"
    ];
  };

  flake.modules.homeManager.gui = {
    lib,
    pkgs,
    config,
    ...
  }: {
    home.sessionVariables.SSH_AUTH_SOCK = "${config.home.homeDirectory}/.bitwarden-ssh-agent.sock";

    home.packages = with pkgs;
      [
        blockbench
        firefox
      ]
      ++ lib.optionals pkgs.stdenv.hostPlatform.isLinux [
        gimp
        kdePackages.kdenlive
        losslesscut-bin
        totem # video thumbnails
        file-roller
        nautilus
        pavucontrol
        crosspipe
        gnome-text-editor
        imv
        mpv
        obs-studio
        bitwarden-desktop
      ]
      ++ lib.optionals pkgs.stdenv.hostPlatform.isDarwin [
        stats
        localsend
      ];
  };
}
