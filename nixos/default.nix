{
  pkgs,
  user,
  host,
  ...
}: {
  imports = [./hardware-configuration.nix];

  nix = {
    settings = {
      experimental-features = ["nix-command" "flakes"];
      auto-optimise-store = true;
      substituters = [
        "https://niri.cachix.org"
      ];
      trusted-public-keys = [
        "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="
      ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };

  users.users.${user} = {
    isNormalUser = true;
    shell = pkgs.nushell;
    extraGroups = ["wheel" "uinput"];
  };

  boot = {
    # Temporary until network cards on x870 motherboards are fixed in the kernel.
    kernelPackages = pkgs.linuxPackages_latest;

    kernelParams = [
      # Needed for lact.
      "amdgpu.ppfeaturemask=0xffffffff"

      # Needed for plymouth.
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
    ];

    initrd = {
      systemd.enable = true;
      verbose = false;
    };
    consoleLogLevel = 0;

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      timeout = 0;
    };

    # Because Windows ¯\_(ツ)_/¯
    supportedFilesystems = ["ntfs"];

    plymouth = {
      enable = true;
      theme = "catppuccin-macchiato";
      themePackages = with pkgs; [catppuccin-plymouth];
    };
  };

  time.timeZone = "Africa/Cairo";
  i18n.extraLocaleSettings.LC_TIME = "en_IE.UTF-8";

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-emoji
    nerd-fonts.iosevka
  ];

  hardware = {
    bluetooth.enable = true;
    graphics = {
      enable = true;
      extraPackages = with pkgs; [
        # Needed for OCCT.
        ocl-icd
        mesa.opencl
      ];
    };
  };

  security.rtkit.enable = true;

  services = {
    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
      jack.enable = true;
    };
    xserver = {
      enable = true;
      excludePackages = [pkgs.xterm];
      videoDrivers = ["amdgpu"];
    };
    flatpak.enable = true;
    syncthing = {
      enable = true;
      inherit user;
      dataDir = "/home/${user}";
    };
    kanata = {
      enable = true;
      keyboards."default".config = ''
        (defsrc rctrl h j k l)
        (defalias rctrl (tap-hold 200 200 rctrl (layer-while-held arrows)))
        (deflayer base   @rctrl   h    j    k    l)
        (deflayer arrows _    left   down up right)
      '';
    };
    displayManager.ly = {
      enable = true;
      settings = {
        clock = "%a %d %b %Y - %H:%M:%S";
        text_in_center = true;
        initial_info_text = host;
        animation = "colormix";
      };
    };
    power-profiles-daemon.enable = false;
    noctalia-shell.enable = true;
  };

  networking = {
    hostName = host;
    firewall = {
      enable = true;
      allowedTCPPorts = [
        # For Syncthing.
        8384
        22000
      ];
      allowedUDPPorts = [
        # For Syncthing.
        22000
        21027
      ];
    };
  };

  programs = {
    nh = {
      enable = true;
      flake = "/home/${user}/projects/nyx";
    };
    steam.enable = true;
    niri = {
      enable = true;
      package = pkgs.niri-stable;
    };
  };

  systemd.services.lactd.wantedBy = ["multi-user.target"];

  environment = {
    systemPackages = with pkgs; [
      nix-output-monitor
      lact
    ];
    sessionVariables = {
      # TODO: Maybe configure with a wayland option.
      NIXOS_OZONE_WL = "1";

      # Needed for OCCT.
      RUSTICL_ENABLE = "radeonsi";
    };
  };

  documentation.enable = false;

  system.stateVersion = "25.05";
}
