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
          @-moz-document url(chrome://browser/content/browser.xhtml){

          /* Additional options required - about:config
          browser.tabs.tabmanager.enabled = false
          xpinstall.signatures.required = false
          extensions.experiments.enabled = true
          widget.use-xdg-desktop-portal.file-picker = 1
          layout.css.devPixelsPerPx = 16
          */

          /* move search bar to bottom */
          :root:not([inFullscreen]) {
            --uc-bottom-toolbar-height: calc(39px + var(--toolbarbutton-outer-padding))
          }
          :root[uidensity="compact"]:not([inFullscreen]) {
            --uc-bottom-toolbar-height: calc(32px + var(--toolbarbutton-outer-padding))
          }
          #browser,
          #customization-container {
            margin-bottom: var(--uc-bottom-toolbar-height, 0px)
          }
          #nav-bar {
            position: fixed !important;
            bottom: 0px;
            /* For some reason -webkit-box behaves internally like -moz-box, but can be used with fixed position. display: flex would work too but it breaks extension menus. */
            display: -webkit-box;
            width: 100%;
            z-index: 1;
          }
          #nav-bar-customization-target {
            -webkit-box-flex: 1;
          }
          .panel-viewstack {
            max-height: unset !important;
          }
          #urlbar[breakout][breakout-extend] {
            display: flex !important;
            flex-direction: column-reverse;
            bottom: 0px !important;
            /* Change to 3-5 px if using compact_urlbar_megabar.css depending on toolbar density */
            top: auto !important;
          }
          .urlbarView-body-inner {
            border-top-style: none !important;
          }
          }

          /* hide enhanced tracking protection shield icon */
          #tracking-protection-icon-container {
            display: none;
          }
          .bookmark-item[container] {
            list-style-image: url("chrome://global/skin/dirListing/folder.png") !important;
          }

          /* hide extensions button */
          /* DISABLED  #unified-extensions-button { display: none } */

          /* hide bookmarks star */
          #star-button-box {display: none !important;}

          /* remove main close button*/
          .titlebar-buttonbox-container{ display:none } 
          
          /* keep popups on top */
          #popup, #menupopup {
            position: fixed !important;
            z-index: 10000 !important;
          }
          #popup-notification {
            margin-top: 0 !important;
            margin-left: 0 !important;
            top: 0 !important;
            right: unset !important;
            left: 0 !important;
            transform: unset !important;
          }


          /* center the text on tabs properly */
          .tabbrowser-tab .tab-label {
            transform: translateY(0.5px); /* how much to move text down */
          }

          /* remove rounding from the edges of tabs */
          :root {
            --tab-block-margin: 0 !important;
            --tab-border-radius: 0 !important;
          }

          /* shrink tab favicon size */
          .tab-icon-image {
            width: 14px !important; /* Adjust the width to your desired size */
            height: 14px !important; /* Adjust the height to your desired size */
          }

          /* hide tab border */
          .tab-background{
            outline: none !important;
            box-shadow: none !important;
          }


          /* TEST */
          menuseparator {
              border-color: var(--panel-separator-color, #50505090) !important;
              margin-left: 5px !important;
              margin-right: 5px !important;
            /*border-image: var(--panel-separator-zap-gradient) 1 !important;*/
            /*border-image: linear-gradient(165deg, #d02f85ee 0%, #b336fcee 8%, #3567fdee 40%, #4e7afdee 60%,#4e89fdee 70%, #d02f85ee 100%) 1 !important;*/
          }
          /*Colores generales*/
          menupopup{background: var(--gradient) !important; border-radius: 6px !important;}
          #PlacesToolbar menupopup { padding: 0px !important;}
          #PlacesToolbar menupopup menupopup{ margin-inline-start: 0px !important; }
          .menupopup-arrowscrollbox {
              background: var(--arrowpanel-background, #50505090) !important;
              background-color: var(--arrowpanel-background, #50505090) !important;
              color: var(--arrowpanel-color, #50505090) !important;
              border: 1px solid transparent !important;
              border-radius: 6px !important;
              margin: 0px !important;
              background-clip: padding-box !important;
              /*ColorFondoAlPasarElMouseSobreItems*/
              --menuitem-hover-background-color: color-mix(in srgb, var(--button-hover-bgcolor) 95%, var(--organizer-color, var(--arrowpanel-color))) !important;
          }
          /*ColoresMenú*/
          .menupopup {
              --panel-color: var(--arrowpanel-color, FieldText) !important;
              /*ColorLetrasDelMenú*/
              --panel-border-color: var(--arrowpanel-border-color, Field)!important;
              /*bordeMenú*/
              --panel-background: var(--arrowpanel-background, Field) !important;
              /*FondoMenú*/
              --menu-color: var(--arrowpanel-color, FieldText) !important;
              /*ColorLetrasAlPasarElMouseSobreItems*/
              --menu-border-color: var(--panel-separator-color, Field) !important;
              /*LineaSeparadoraItems*/
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
