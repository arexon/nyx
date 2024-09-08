{
  inputs,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.nyx.apps.discord;
in {
  imports = [inputs.nixcord.homeManagerModules.nixcord];

  options.nyx.apps.discord = {
    enable = mkBoolOpt false "Whether to enable Discord.";
  };

  config = mkIf cfg.enable {
    programs.nixcord = {
      enable = true;
      quickCss = builtins.readFile ./theme.css;
      config = {
        useQuickCss = true;
        frameless = true;
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
          imageZoom.enable = true;
          messageLogger = {
            enable = true;
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
        };
      };
    };
  };
}
