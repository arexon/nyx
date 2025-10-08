{config, ...}: {
  stylix.targets.nixcord.enable = false;

  programs.nixcord = {
    enable = true;
    config = {
      frameless = true;
      themeLinks = ["https://refact0r.github.io/midnight-discord/build/midnight.css"];
      enabledThemes = ["kanagawa.css"];

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
  };

  xdg.configFile."Vencord/themes/kanagawa.css".text = with config.lib.stylix.colors.withHashtag; ''
    body {
      --font: "figtree";
      --code-font: "Iosevka NF";
      font-weight: 400 /* normal text font weight. DOES NOT AFFECT BOLD TEXT */;

      /* sizes */
      --gap: 12px; /* spacing between panels */
      --divider-thickness: 4px; /* thickness of unread messages divider and highlighted message borders */
      --border-thickness: 1px; /* thickness of borders around main panels. DOES NOT AFFECT OTHER BORDERS */

      /* animation/transition options */
      --animations: on; /* off: disable animations/transitions, on: enable animations/transitions */
      --list-item-transition: 0.2s ease; /* transition for list items */
      --dms-icon-svg-transition: 0.4s ease; /* transition for the dms icon */
      --border-hover-transition: 0.2s ease; /* transition for borders when hovered */

      /* top bar options */
      --top-bar-height: var(--gap); /* height of the top bar (discord default is 36px, old discord style is 24px, var(--gap) recommended if button position is set to titlebar) */
      --top-bar-button-position: titlebar; /* off: default position, hide: hide buttons completely, serverlist: move inbox button to server list, titlebar: move inbox button to channel titlebar (will hide title) */
      --top-bar-title-position: off; /* off: default centered position, hide: hide title completely, left: left align title (like old discord) */
      --subtle-top-bar-title: off; /* off: default, on: hide the icon and use subtle text color (like old discord) */

      /* window controls */
      --custom-window-controls: on; /* off: default window controls, on: custom window controls */
      --window-control-size: 14px; /* size of custom window controls */

      /* background image options */
      --background-image: off; /* off: no background image, on: enable background image (must set url variable below) */
      --background-image-url: url(""); /* url of the background image */

      /* transparency/blur options */
      /* NOTE: TO USE TRANSPARENCY/BLUR, YOU MUST HAVE TRANSPARENT BG COLORS. FOR EXAMPLE: --bg-4: hsla(220, 15%, 10%, 0.7); */
      --transparency-tweaks: off; /* off: no changes, on: remove some elements for better transparency */
      --remove-bg-layer: off; /* off: no changes, on: remove the base --bg-3 layer for use with window transparency (WILL OVERRIDE BACKGROUND IMAGE) */
      --panel-blur: off; /* off: no changes, on: blur the background of panels */
      --blur-amount: 12px; /* amount of blur */
      --bg-floating: var(--bg-3); /* set this to a more opaque color if floating panels look too transparent. only applies if panel blur is on  */

      /* chatbar options */
      --custom-chatbar: aligned; /* off: default chatbar, aligned: chatbar aligned with the user panel, separated: chatbar separated from chat */
      --chatbar-height: 47px; /* height of the chatbar (52px by default, 47px recommended for aligned, 56px recommended for separated) */
      --chatbar-padding: 8px; /* padding of the chatbar. only applies in aligned mode. */

      /* other options */
      --small-user-panel: on; /* off: default user panel, on: smaller user panel like in old discord */
    }

    :root {
      --colors: on;

      /* text colors */
      --text-0: var(--bg-3); /* text on colored elements */
      --text-1: ${base06}; /* other normally white text */
      --text-2: ${base06}; /* headings and important text */
      --text-3: ${base05}; /* normal text */
      --text-4: ${base06}; /* icon buttons and channels */
      --text-5: ${base04}; /* muted channels/chats and timestamps */
      --interactive-active: ${base05};

      /* background and dark colors */
      --bg-1: ${base0D}; /* dark buttons when clicked */
      --bg-2: ${base02}; /* dark buttons */
      --bg-3: ${base01}; /* spacing, secondary elements */
      --bg-4: ${base00}; /* main background color */
      --hover: ${base0D}1a; /* channels and buttons when hovered */
      --active: ${base03}33; /* channels and buttons when clicked or selected */
      --active-2: ${base03}10; /* extra state for transparent buttons */
      --message-hover: hsla(0, 0%, 0%, 0.1); /* messages when hovered */

      /* accent colors */
      --accent-1: ${base0E}; /* links and other accent text */
      --accent-2: ${base0E}; /* small accent elements */
      --accent-3: ${base0E}; /* accent buttons */
      --accent-4: ${base0E}; /* accent buttons when hovered */
      --accent-5: ${base0E}; /* accent buttons when clicked */
      --accent-new: ${base08}; /* stuff that's normally red like mute/deafen buttons */
      --mention: linear-gradient(to right, color-mix(in hsl, var(--accent-2), transparent 90%) 40%, transparent); /* background of messages that mention you */
      --mention-hover: linear-gradient(to right, color-mix(in hsl, var(--accent-2), transparent 95%) 40%, transparent); /* background of messages that mention you when hovered */
      --reply: linear-gradient(to right, color-mix(in hsl, var(--text-3), transparent 90%) 40%, transparent); /* background of messages that reply to you */
      --reply-hover: linear-gradient(to right, color-mix(in hsl, var(--text-3), transparent 95%) 40%, transparent); /* background of messages that reply to you when hovered */

      /* status indicator colors */
      --online: ${base0B};
      --dnd: ${base08};
      --idle: ${base09};
      --streaming: ${base0E};
      --offline: ${base07};

      /* border colors */
      --border-light: var(--hover); /* general light border color */
      --border: var(--active); /* general normal border color */
      --border-hover: var(--active); /* border color of panels when hovered */
      --button-border: hsl(0, 0%, 100%, 0.1); /* neutral border color of buttons */

      /* base colors */
      --red-1: ${base08};
      --red-2: ${base08};
      --red-3: ${base08};
      --red-4: ${base08};
      --red-5: ${base08};

      --green-1: ${base0B};
      --green-2: ${base0B};
      --green-3: ${base0B};
      --green-4: ${base0B};
      --green-5: ${base0B};

      --blue-1: ${base0D};
      --blue-2: ${base0D};
      --blue-3: ${base0D};
      --blue-4: ${base0D};
      --blue-5: ${base0D};

      --yellow-1: ${base0A};
      --yellow-2: ${base0A};
      --yellow-3: ${base0A};
      --yellow-4: ${base0A};
      --yellow-5: ${base0A};

      --purple-1: ${base0E};
      --purple-2: ${base0E};
      --purple-3: ${base0E};
      --purple-4: ${base0E};
      --purple-5: ${base0E};
    }
  '';

  programs.niri.settings = {
    window-rules = [
      {
        matches = [{app-id = "^discord$";}];
        open-on-workspace = "III";
        default-column-width.proportion = 0.7;
      }
    ];
  };
}
