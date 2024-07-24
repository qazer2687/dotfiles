{
  self,
  lib,
  config,
  pkgs,
  ...
}: {
  options.modules.firefox.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.firefox.enable {
    programs.firefox = {
      enable = true;
      profiles."0" = {
        name = "0";
        isDefault = true;
        id = 0;
        #search.default = "Google"; # i need calculator

        # Extensions
        /*
          extensions = with config.nur.repos.rycee.firefox-addons; [
          ublock-origin
          keepa
          auto-tab-discard
          youtube-recommended-videos
          statshunters
        ];
        */

        # Asahi Widevine Support
        settings = lib.mkIf pkgs.stdenv.hostPlatform.isAarch64 {
          "media.gmp-widevinecdm.version" = pkgs.widevinecdm-aarch64.version;
          "media.gmp-widevinecdm.visible" = true;
          "media.gmp-widevinecdm.enabled" = true;
          "media.gmp-widevinecdm.autoupdate" = false;
          "media.eme.enabled" = true;
          "media.eme.encrypted-media-encryption-scheme.enabled" = true;
        };

        userChrome = ''
          @-moz-document url(chrome://browser/content/browser.xhtml){

            /* Additional options required
            browser.tabs.tabmanager.enabled = false
            */

            :root:not([inFullscreen]){
              --uc-bottom-toolbar-height: calc(39px + var(--toolbarbutton-outer-padding) )
            }

            :root[uidensity="compact"]:not([inFullscreen]){
              --uc-bottom-toolbar-height: calc(32px + var(--toolbarbutton-outer-padding) )
            }

            #browser,
            #customization-container{ margin-bottom: var(--uc-bottom-toolbar-height,0px) }

            #nav-bar{
              position: fixed !important;
              bottom: 0px;
              /* For some reason -webkit-box behaves internally like -moz-box, but can be used with fixed position. display: flex would work too but it breaks extension menus. */
              display: -webkit-box;
              width: 100%;
              z-index: 1;
            }
            #nav-bar-customization-target{ -webkit-box-flex: 1; }

            /* Fix panels sizing */
            .panel-viewstack{ max-height: unset !important; }

            #urlbar[breakout][breakout-extend]{
              display: flex !important;
              flex-direction: column-reverse;
              bottom: 0px !important; /* Change to 3-5 px if using compact_urlbar_megabar.css depending on toolbar density */
              top: auto !important;
            }

            .urlbarView-body-inner{ border-top-style: none !important; }
          }

          /* hide enhanced tracking protection shield icon */
          #tracking-protection-icon-container {
            display: none;
          }
          .bookmark-item[container] {
            list-style-image: url("chrome://global/skin/dirListing/folder.png") !important;
          }

          /* hide extensions button */
          #unified-extensions-button { display: none }

          /* hide bookmarks star */
          #star-button-box {display: none !important;}
        '';
      };
    };

    # Asahi Widevine Support
    home.file."firefox-widevinecdm" = lib.mkIf pkgs.stdenv.hostPlatform.isAarch64 {
      enable = true;
      target = ".mozilla/firefox/default/gmp-widevinecdm";
      source = pkgs.runCommandLocal "firefox-widevinecdm" { } ''
        out=$out/${pkgs.widevinecdm-aarch64.version}
        mkdir -p $out
        ln -s ${pkgs.widevinecdm-aarch64}/manifest.json $out/manifest.json
        ln -s ${pkgs.widevinecdm-aarch64}/libwidevinecdm.so $out/libwidevinecdm.so
      '';
      recursive = true;
    };
  };
}
