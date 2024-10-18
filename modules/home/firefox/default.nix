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
              font-size: 0.9em !important; /* Adjusted font size */
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

          /* Other existing styles... */

          /* Center icons and text in URL bar */
          #urlbar-container {
              display: flex !important;
              align-items: center !important; /* Center vertically */
              font-size: 0.9em !important; /* Adjusted font size */
          }

          #urlbar-input {
              margin-inline: 1mm !important;
              padding: 0 !important; /* Remove padding */
              font-size: 0.9em !important; /* Adjusted font size */
              transform: scale(0.9); /* Shrinks the icons slightly */
              transform-origin: left; /* Adjust the origin for scaling */
          }

          /* Non-selected/non-pinned tabs */
          .tabbrowser-tab {
              padding: 0 !important;
              display: flex !important;
              justify-content: center !important;
              align-items: center !important; /* Center vertically */
              height: 20px !important; /* Set to 20px */
              min-height: 20px !important; /* Prevent expansion */
              max-height: 20px !important; /* Prevent any potential expansion */
              font-size: 0.9em !important; /* Adjusted font size */
          }

          .tabbrowser-tab .tab-icon {
              transform: scale(0.9); /* Shrinks the tab icons slightly */
              transform-origin: center; /* Center the scaling */
          }

          /* Center icons and text in tabs */
          .tabbrowser-tab > .tab-close-button,
          .tabbrowser-tab .tab-icon {
              display: flex !important;
              align-items: center !important; /* Center vertically */
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
