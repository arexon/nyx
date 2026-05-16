{
  flake.modules.nixos.zsa = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [keymapp];
    hardware.keyboard.zsa.enable = true;
  };
}
