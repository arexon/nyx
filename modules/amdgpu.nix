{
  flake.modules.nixos.amdgpu = {pkgs, ...}: {
    hardware.graphics = {
      enable = true;
      extraPackages = with pkgs; [
        ocl-icd
        mesa.opencl
      ];
    };

    boot.kernelParams = [
      "amdgpu.ppfeaturemask=0xffffffff"
    ];
    services.lact.enable = true;
  };
}
