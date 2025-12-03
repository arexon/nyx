{
  inputs,
  pkgs,
  config,
  ...
}: let
  pkgs-25-05 = inputs.nixpkgs-25-05.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in {
  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      obs-pipewire-audio-capture
      pkgs-25-05.obs-studio-plugins.input-overlay
    ];
  };

  xdg.configFile."obs-studio/themes/kanagawa.ovt".text = with config.lib.stylix.colors.withHashtag; ''
    @OBSThemeMeta {
        name: 'Kanagawa';
        id: 'com.obsproject.Yami.Kanagawa';
        extends: 'com.obsproject.Yami';
        author: 'arexon';
        dark: 'true';
    }

    @OBSThemeVars {
        --grey1: ${base04};
        --grey2: ${base04};
        --grey3: ${base03};
        --grey4: ${base03};
        --grey5: ${base02};
        --grey6: ${base02};
        --grey7: ${base00};
        --grey8: ${base01};

        --white1: ${base05};

        --primary_lighter: ${base0E};
        --primary_light: ${base0E};
        --primary: ${base0E};
        --primary_dark: ${base0E};
        --primary_darker: ${base0E};

        --palette_link: ${base0D};
        --palette_linkVisited: ${base0D};

        --text: ${base06};
        --text_light: ${base05};
        --text_muted: ${base07};
        --text_disabled: var(--text_muted);
        --text_inactive: var(--text_muted);
    }
  '';
}
