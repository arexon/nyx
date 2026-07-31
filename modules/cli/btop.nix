{
  flake.modules.homeManager.cli = {
    pkgs,
    lib,
    ...
  }: {
    stylix.targets.btop.enable = true;

    programs.btop = {
      enable = true;
      package = pkgs.btop.override (lib.optionalAttrs pkgs.stdenv.hostPlatform.isLinux {
        rocmSupport = true;
      });
      settings = {
        theme_background = false;
        vim_keys = true;
        rounded_corners = false;
        proc_gradient = false;
        base_10_sizes = true;
        update_ms = 500;
      };
    };
  };
}
