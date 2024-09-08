{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.nyx.cli-apps.fzf;

  inherit (config.colorscheme) palette;
in {
  options.nyx.cli-apps.fzf = {
    enable = mkBoolOpt false "Whether to enable fzf.";
  };

  config = mkIf cfg.enable {
    programs.fzf = {
      enable = true;
      colors = {
        fg = "#${palette.base06}";
        bg = "#${palette.base01}";
        hl = "#${palette.base08}";
        "fg+" = "#${palette.base07}";
        "bg+" = "#${palette.base01}";
        "hl+" = "#${palette.base08}";
        gutter = "#${palette.base01}";
        info = "#${palette.base0A}";
        pointer = "#${palette.base0B}";
        prompt = "#${palette.base0B}";
        spinner = "#${palette.base0A}";
        border = "#${palette.base01}";
        header = "#${palette.base0C}";
      };
      defaultOptions = [
        "--prompt '-> '"
        "--pointer ':>'"
        "--info 'inline-right'"
      ];
    };
  };
}
