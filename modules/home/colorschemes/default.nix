{inputs, ...}: {
  imports = [
    inputs.nix-colors.homeManagerModules.default
  ];

  colorscheme = {
    slug = "kanagawa";
    palette = {
      base00 = "#1F1F28";
      base01 = "#181820";
      base02 = "#2A2A37";
      base03 = "#363646";
      base04 = "#54546D";
      base05 = "#727169";
      base06 = "#C8C093";
      base07 = "#DCD7BA";
      base08 = "#C34043"; # red
      base09 = "#FFA066"; # orange
      base0A = "#DCA561"; # yellow
      base0B = "#76946A"; # green
      base0C = "#7FB4CA"; # cyan
      base0D = "#7E9CD8"; # blue
      base0E = "#957FB8"; # purple
      base0F = "#D27E99"; # pink
    };
  };
}
