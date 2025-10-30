{
  stylix.targets.nixcord.enable = false;

  programs.nixcord = {
    enable = true;
    discord.enable = false;
    vesktop.enable = true;
    config = {
      frameless = true;
      themeLinks = [
        "https://refact0r.github.io/midnight-discord/build/midnight.css"
        "https://raw.githubusercontent.com/refact0r/midnight-discord/refs/heads/master/themes/flavors/midnight-catppuccin-macchiato.theme.css"
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
        betterGifPicker.enable = true;
        betterNotesBox = {
          enable = true;
          hide = true;
        };
        betterUploadButton.enable = true;
        biggerStreamPreview.enable = true;
        favoriteGifSearch.enable = true;
        messageLogger = {
          enable = true;
          ignoreBots = true;
          ignoreSelf = true;
        };
        moreUserTags = {
          enable = true;
          dontShowForBots = true;
        };
        permissionsViewer.enable = true;
        platformIndicators.enable = true;
        previewMessage.enable = true;
        quickReply = {
          enable = true;
          shouldMention = "enabled";
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
        translate = {
          enable = true;
        };
      };
    };
    quickCss = ''
      body {
        --custom-dms-icon: off;
        --custom-dms-background: off;
      }
    '';
  };
}
