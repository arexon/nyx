{
  config,
  pkgs,
  user,
  host,
  modulesPath,
  lib,
  ...
}: let
  inherit (lib) getExe;
in {
  imports = [(modulesPath + "/installer/scan/not-detected.nix")];

  nix = {
    settings = {
      experimental-features = ["nix-command" "flakes"];
      auto-optimise-store = true;
      substituters = [
        "https://niri.cachix.org"
        "https://attic.xuyh0120.win/lantian"
      ];
      trusted-public-keys = [
        "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="
        "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc="
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
    shell = pkgs.fish;
    extraGroups = ["wheel" "uinput"];
  };

  boot = {
    extraModulePackages = with config.boot.kernelPackages; [r8125];

    kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest;
    kernelModules = ["kvm-amd" "r8169"];
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
      availableKernelModules = ["nvme" "xhci_pci" "ahci" "thunderbolt" "usb_storage" "usbhid" "sd_mod"];
      kernelModules = ["dm-snapshot" "r8125" "amdgpu"];
      luks.devices.enyc.device = "/dev/disk/by-label/GARGANTUA";
      systemd.enable = true;
      verbose = false;
    };
    consoleLogLevel = 0;

    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 5;
      };
      efi.canTouchEfiVariables = true;
      timeout = 0;
    };

    # Because Windows ¯\_(ツ)_/¯
    supportedFilesystems = ["ntfs"];

    plymouth.enable = true;
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/f93d6472-5532-46cd-91a5-7e5dcd0b5e70";
      fsType = "ext4";
    };
    "/home" = {
      device = "/dev/disk/by-uuid/84e3b1ea-368d-44a7-8b28-1a01fe85d42c";
      fsType = "ext4";
    };
    "/nix" = {
      device = "/dev/disk/by-uuid/2c97b306-4fc5-460f-9ed8-4645fd5d45c1";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/BAF2-8E18";
      fsType = "vfat";
      options = ["fmask=0022" "dmask=0022"];
    };
  };
  swapDevices = [
    {device = "/dev/disk/by-uuid/33014247-6ab4-4e01-8410-3489951be101";}
  ];

  time.timeZone = "Africa/Cairo";
  i18n.extraLocaleSettings.LC_TIME = "en_US.UTF-8";

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-color-emoji
    nerd-fonts.iosevka
  ];

  hardware = {
    bluetooth.enable = true;
    cpu.amd.updateMicrocode = config.hardware.enableRedistributableFirmware;
    graphics = {
      enable = true;
      extraPackages = with pkgs; [
        # Needed for OCCT.
        ocl-icd
        mesa.opencl
      ];
    };
  };

  security = {
    rtkit.enable = true;
    wrappers.livesplit-one = {
      owner = "root";
      group = "root";
      capabilities = "cap_sys_ptrace+eip";
      source = "/run/current-system/sw/bin/livesplit-one";
    };
  };

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
    power-profiles-daemon.enable = false;
    noctalia-shell.enable = true;
    lact.enable = true;
    greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${getExe pkgs.tuigreet} --cmd ${pkgs.niri}/bin/niri-session";
          user = "greeter";
        };
      };
    };
  };

  networking = {
    hostName = host;
    useDHCP = true;
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
    steam = {
      enable = true;
      extraCompatPackages = with pkgs; [proton-ge-bin proton-gdk-bin];
    };
    niri = {
      enable = true;
      package = pkgs.niri-stable;
    };
    fish.enable = true;
  };

  environment = {
    systemPackages = with pkgs; [nix-output-monitor livesplit-one];
    sessionVariables = {
      # TODO: Maybe configure with a wayland option.
      NIXOS_OZONE_WL = "1";

      # Needed for OCCT.
      RUSTICL_ENABLE = "radeonsi";
    };
    variables.QT_QPA_PLATFORMTHEME = lib.mkForce "gtk3";
  };

  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
  };

  documentation.enable = false;

  system.stateVersion = "25.05";
}
