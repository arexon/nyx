{pkgs, ...}: {
  home.packages = with pkgs; [
    prismlauncher
    mangohud
  ];

  services.flatpak = {
    remotes = [
      {
        name = "flathub-beta";
        location = "https://flathub.org/beta-repo/flathub-beta.flatpakrepo";
      }
    ];
    packages = [
      {
        appId = "io.mrarm.mcpelauncher";
        origin = "flathub-beta";
      }
    ];
  };
}
