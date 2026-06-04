{inputs, ...}: {
  flake-file.inputs = {
    nixcord = {
      url = "github:FlameFlag/nixcord";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  flake.modules.homeManager.gui = {
    imports = [
      inputs.nixcord.homeModules.nixcord
    ];

    stylix.targets.nixcord.enable = false;

    programs.nixcord = {
      enable = true;
      discord = {
        krisp.enable = true;
        equicord.enable = true;
        vencord.enable = false;
      };
      config = {
        frameless = true;
        notifyAboutUpdates = true;
        enabledThemeLinks = [
          "https://refact0r.github.io/midnight-discord/build/midnight.css"
          "https://raw.githubusercontent.com/refact0r/midnight-discord/refs/heads/master/themes/flavors/midnight-catppuccin-mocha.theme.css"
        ];
        useQuickCss = true;

        plugins = {
          alwaysTrust.enable = true;
          anonymiseFileNames = {
            enable = true;
            anonymiseByDefault = true;
            randomisedLength = 8;
          };
          betterGifAltText.enable = true;
          betterUploadButton.enable = true;
          biggerStreamPreview.enable = true;
          messageLogger = {
            enable = true;
            ignoreBots = true;
            ignoreSelf = true;
          };
          permissionsViewer.enable = true;
          platformIndicators.enable = true;
          previewMessage.enable = true;
          quickReply = {
            enable = true;
            shouldMention = 1;
          };
          relationshipNotifier.enable = true;
          showHiddenThings.enable = true;
          showTimeoutDuration.enable = true;
          noTypingAnimation.enable = true;
          spotifyCrack = {
            enable = true;
            keepSpotifyActivityOnIdle = true;
          };
          spotifyShareCommands.enable = true;
          translate.enable = true;
          fixSpotifyEmbeds.enable = true;
          forceOwnerCrown.enable = true;
          friendsSince.enable = true;
          sendTimestamps.enable = true;
          voiceChatDoubleClick.enable = true;
          openInApp.enable = true;
          unindent.enable = true;
          customIdle.enable = true;
          gifCollections = {
            enable = true;
            preventDuplicates = true;
          };
        };
      };
      quickCss = ''
        body {
          --custom-dms-icon: off;
          --custom-dms-background: off;
          --text-0: var(--text-2);
          --custom-chatbar: separated;
          --chatbar-height: 56px;
          --small-user-panel: off;
        }
      '';
    };

    programs.niri.settings = {
      window-rules = [
        {
          matches = [{app-id = "discord";}];
          open-on-workspace = "III";
          default-column-width.proportion = 0.6;
        }
      ];
    };
  };
}
