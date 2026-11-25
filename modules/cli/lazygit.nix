{
  flake.modules.homeManager.cli = {
    config,
    lib,
    pkgs,
    ...
  }: let
    inherit (config.lib.stylix) colors;

    tint = name: weight: let
      channel = i: let
        bg = lib.fromHexString (builtins.substring i 2 colors.base00);
        fg = lib.fromHexString (builtins.substring i 2 colors.${name});
        mixed = (bg * (100 - weight) + fg * weight) / 100;
      in
        lib.fixedWidthString 2 "0" (lib.toLower (lib.toHexString mixed));
    in "#${lib.concatMapStrings channel [0 2 4]}";

    deltaConfig = pkgs.writeText "delta.gitconfig" (lib.generators.toGitINI {
      delta = {
        paging = "never";
        syntax-theme = "base16-stylix";
        minus-style = "syntax ${tint "base08" 15}";
        minus-emph-style = "syntax ${tint "base08" 35}";
        plus-style = "syntax ${tint "base0B" 15}";
        plus-emph-style = "syntax ${tint "base0B" 35}";
      };
    });
  in {
    stylix.targets.lazygit.enable = true;

    programs.lazygit = {
      enable = true;
      settings = {
        gui = {
          skipDiscardChangeWarning = true;
          showCommandLog = false;
        };
        git = {
          overrideGpg = true;
          diffRenderers = [
            {
              colorArg = "always";
              command = "${lib.getExe pkgs.delta} --config ${deltaConfig}";
            }
          ];
        };
      };
    };
  };
}
