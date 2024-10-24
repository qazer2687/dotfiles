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
            height: 20px !important;
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
            padding: 0 !important; /* Remove padding */
          }

          /* Center icons and text in URL bar */
          #urlbar-container {
            display: flex !important;
            align-items: center !important;
          }

          /* Remove padding, margins, and close buttons from non-selected/non-pinned tabs */
          .tabbrowser-tab {
            padding: 0 !important;
            display: flex !important;
            justify-content: center !important;
            align-items: center !important;
            height: 20px !important; /* Set to 20px */
            min-height: 20px !important; /* Prevent expansion */
            max-height: 20px !important; /* Prevent any potential expansion */
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

          /* Center icons and text in tabs */
          .tabbrowser-tab > .tab-close-button,
          .tabbrowser-tab .tab-icon {
            display: flex !important;
            align-items: center !important;
            justify-content: center !important;
          }

          /* Remove specified elements */
          .titlebar-buttonbox-container,
          .urlbar-go-button,
          #identity-box,
          #PersonalToolbar,
          #context-navigation,
          #context-sep-navigation,
          #toolbar-menubar,
          #identity-icon-label,
          #tracking-protection-icon-container,
          #page-action-buttons > :not(#urlbar-zoom-button),
          #alltabs-button,
          #forward-button,
          #back-button,
          #PanelUI-menu-button {
            display: none !important;
          }

          /* Shrink tab text and icons */
          .tabbrowser-tab .tab-icon-image {
            max-height: 14px; /* Adjust icon size */
            max-width: 14px; /* Adjust icon size */
            display: flex;
            align-items: center; /* Center vertically */
            margin-top: auto; /* Center in tab */
            margin-bottom: auto; /* Center in tab */ */
          }

          .tabbrowser-tab .tab-label {
            font-size: 14px; /* Adjust font size */
            line-height: 16px; /* Align text vertically */
            display: flex;
            align-items: center; /* Center vertically */
            height: 20px; /* Match tab height */
          }

          /* Make the extension dropdown button icon invisible and small */
          .toolbarbutton-1 .toolbarbutton-icon {
              opacity: 0; /* Make icon invisible */
              height: 2px; /* Reduce height to minimal */
              width: 2px; /* Reduce width to minimal */
              position: absolute; /* Position the icon absolutely */
              right: 0; /* Align it to the right */
          }

          #unified-extensions-view #unified-extensions-manage-extensions .toolbarbutton-text::before {
              content: "• • •";
              font-size: 15px;
              visibility: visible !important;
              display: block;
              text-align: center;
          }

          #unified-extensions-panel #unified-extensions-view {
              width: 100% !important;
          }

          #unified-extensions-view{
              --uei-icon-size: 22px;
              --firefoxcss-number-of-extensions-in-a-row: 4;
          }


          #unified-extensions-view .unified-extensions-item-menu-button.subviewbutton,
          #unified-extensions-view .unified-extensions-item-action-button .unified-extensions-item-contents{
              display:none !important;
          }

          #unified-extensions-view .panel-subview-body {
              padding: 10px !important;
          }

          #unified-extensions-view .unified-extensions-item .unified-extensions-item-icon, 
          #unified-extensions-view .unified-extensions-item .toolbarbutton-badge-stack {
              margin-inline-end: 0px !important;
          }

          #unified-extensions-view #overflowed-extensions-list,
          #unified-extensions-view #unified-extensions-area,
          #unified-extensions-view .unified-extensions-list {
              display: grid !important;
              grid-template-columns: repeat(var(--firefoxcss-number-of-extensions-in-a-row),auto);
              justify-items:left !important;
              align-items:left !important;
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
