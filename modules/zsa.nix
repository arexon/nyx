{
  flake.modules.nixos.zsa = {
    hardware.keyboard.zsa.enable = true;
  };

  flake.modules.homeManager.zsa = {pkgs, ...}: {
    home.packages = with pkgs; [keymapp];
  };
}
