{
  lib,
  config,
  pkgs,
  ...
}: {
  options.modules.firefox.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.firefox.enable {
    programs.firefox = {
      enable = true;
      # Required for paxmod to work.
      package = pkgs.firefox-devedition;
      # The profile is named like this because firefox devedition 
      # refuses to open normal profiles.
      profiles."dev-edition-default" = {
        name = "dev-edition-default";
        isDefault = true;
        id = 0;
        
        # This doesn't work properly, it leads to issues with rebuilding and leaves
        # extensions stuck as disabled.
        /*
          extensions = with config.nur.repos.rycee.firefox-addons; [
          ublock-origin
          keepa
          auto-tab-discard
          youtube-recommended-videos
          statshunters
        ];
        */

        userChrome = ''
          /* Make interface on a single bar */
          #navigator-toolbox {
            display: flex !important;
            height: 7mm !important;
            flex-direction: row !important;
            align-items: center !important;
            border-bottom: 0 !important;
          }
          #nav-bar {
            order: 1 !important;
            background-color: transparent !important;
          }
          #titlebar {
            order: 2 !important;
            flex-grow: 1 !important;
            background-color: transparent !important;
          }

          /* Remove all shadows and round corners */
          * {
            border-radius: 0 !important;
            text-shadow: none !important;
            box-shadow: none !important;
          }

          /* Auto hide tab bar */
          #main-window:not([customizing]) #navigator-toolbox:focus-within #TabsToolbar,
          #main-window:not([customizing]) #nav-bar:focus-within #back-button {
            visibility: collapse !important;
          }

          /* Auto hide URL bar */
          #main-window:not([customizing]) #nav-bar #urlbar-container {
            width: 0 !important;
            margin: 0 !important;
          }
          #main-window:not([customizing]) #nav-bar:focus-within {
            width: 100% !important;
          }

          /* Remove border/separators from search results */
          #urlbar-background {
            outline: none !important;
          }
          #urlbar-input {
            margin-inline: 1mm !important;
          }
          .urlbarView-body-inner {
            border-top: none !important;
          }

          /* Remove padding, margins, and close buttons from non-selected/non-pinned tabs */
          .tabbrowser-tab {
            padding: 0 !important;
          }
          .tabbrowser-tab:not([pinned]) {
            margin-inline-start: 0 !important;
          }
          .tabbrowser-tab:not([pinned]):not([selected]) .tab-close-button {
            display: none !important;
          }
          .tab-background {
            margin: 0 !important;
          }

          /* Remove all these elements */
          .titlebar-buttonbox-container, /* close/minimize/maximize buttons container */
          .urlbar-go-button, /* arrow icon in the URL bar (submit button) */
          #identity-box, /* magnify glass in the URL bar */
          #PersonalToolbar, /* bookmark toolbar */
          #context-navigation, /* back/forward options in the right-click context menu */
          #context-sep-navigation, /* separator in the back/forward context menu */
          #toolbar-menubar, /* traditional menu bar (File, Edit, View, etc.) */
          #identity-icon-label, /* security label (like "Secure" or padlock in the URL bar) */
          #tracking-protection-icon-container, /* container for the tracking protection shield icon */
          #page-action-buttons > :not(#urlbar-zoom-button), /* all page action buttons except zoom */
          /*
          #unified-extensions-button,
          #unified-extensions-button > .toolbarbutton-icon,
          */
          #alltabs-button, /* button for showing all open tabs in a dropdown menu */
          #forward-button, /* forward navigation button */
          #back-button, /* back navigation button */
          #PanelUI-menu-button /* main menu button (hamburger menu) */ {
            display: none !important;
          }


          /* chatgpt solution idk to center the tabs properly*/
          .tabbrowser-tab {
            display: flex !important; /* Use flexbox */
            justify-content: center !important; /* Center horizontally */
            align-items: center !important; /* Center vertically */
          }
          .tabbrowser-tab {
            height: 28px; /* Fix for tab height, adjust if needed */
          }
          .tab-label {
            margin: 0 !important; /* Remove default margin */
            text-align: center !important; /* Center text */
          }

          .tabbrowser-tab {
            height: 20px; /* or your desired height */
          }

          /* Ensure selected tab has the same height */
          .tabbrowser-tab[selected] {
            height: 20px !important; /* Match the height of non-selected tabs */
          }

          /* Set a consistent height for the tab bar */
          #TabsToolbar {
            height: 20px !important; /* Set to 20px */
            min-height: 20px !important; /* Ensure it doesn't expand */
          }

          /* Set a consistent height for the search bar */
          #urlbar-container {
            height: 20px !important; /* Match with the tab height */
            min-height: 20px !important; /* Prevent expansion */
            padding: 0 !important; /* Remove any default padding */
          }

          /* Shrink font size for the search input */
          #urlbar-input {
            font-size: 12px !important; /* Adjust as needed */
            line-height: 20px !important; /* Match with the search bar height */
          }

          /* Ensure tab height is set correctly */
          .tabbrowser-tab {
            height: 20px !important; /* Set to 20px */
            min-height: 20px !important; /* Prevent expansion */
            max-height: 20px !important; /* Prevent any potential expansion */
            padding: 0 !important; /* Remove any default padding */
          }

          /* Adjust the tab label height */
          .tab-label {
            line-height: 20px !important; /* Match with the tab height */
          }

        '';
      };
    };

    # Asahi Widevine Support
    # Note that in order for Netflix to work, this needs to be paried with
    # a web user-agent spoofer configured to emulate Chrome on ChromeOS.
    home.file."firefox-widevinecdm" = lib.mkIf pkgs.stdenv.hostPlatform.isAarch64 {
      enable = true;
      target = ".mozilla/firefox/dev-edition-default/gmp-widevinecdm";
      source = pkgs.runCommandLocal "firefox-widevinecdm" {} ''
        out=$out/${pkgs.widevinecdm-aarch64.version}
        mkdir -p $out
        ln -s ${pkgs.widevinecdm-aarch64}/manifest.json $out/manifest.json
        ln -s ${pkgs.widevinecdm-aarch64}/libwidevinecdm.so $out/libwidevinecdm.so
      '';
      recursive = true;
    };
    programs.firefox.profiles."dev-edition-default".settings = lib.mkIf pkgs.stdenv.hostPlatform.isAarch64 {
      "media.gmp-widevinecdm.version" = pkgs.widevinecdm-aarch64.version;
      "media.gmp-widevinecdm.visible" = true;
      "media.gmp-widevinecdm.enabled" = true;
      "media.gmp-widevinecdm.autoupdate" = false;
      "media.eme.enabled" = true;
      "media.eme.encrypted-media-encryption-scheme.enabled" = true;
    };
  };
}
