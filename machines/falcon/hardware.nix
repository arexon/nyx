{
  config,
  lib,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot = {
    extraModulePackages = with config.boot.kernelPackages; [
      r8125
    ];
    initrd = {
      availableKernelModules = ["nvme" "xhci_pci" "ahci" "thunderbolt" "usb_storage" "usbhid" "sd_mod"];
      kernelModules = ["dm-snapshot" "r8125"];
      luks.devices.enyc.device = "/dev/disk/by-label/GARGANTUA";
    };
    kernelModules = ["kvm-amd" "r8169"];
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

  networking.useDHCP = lib.mkDefault true;
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
