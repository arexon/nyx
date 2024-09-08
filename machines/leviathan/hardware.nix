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
    initrd = {
      availableKernelModules = ["xhci_pci" "ahci" "nvme" "usb_storage" "usbhid" "sd_mod"];
      kernelModules = ["dm-snapshot"];
      luks.devices.enyc.device = "/dev/disk/by-uuid/82154409-92bb-4da5-b9d3-c50aeb520f5c";
    };
    kernelModules = ["kvm-intel"];
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/faafb1c0-2c57-4ba4-bd8e-430b20b91fc2";
      fsType = "ext4";
    };
    "/nix" = {
      device = "/dev/disk/by-uuid/e6228eff-a2d1-4721-99fd-5ce72052e865";
      fsType = "ext4";
    };
    "/home" = {
      device = "/dev/disk/by-uuid/052a1537-65d7-4ba6-82dd-0859f0203dfe";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/1183-4344";
      fsType = "vfat";
      options = ["fmask=0022" "dmask=0022"];
    };
  };

  swapDevices = [
    {
      device = "/dev/disk/by-uuid/21771d01-77a4-4126-ab25-b6360f29c7d5";
    }
  ];

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
