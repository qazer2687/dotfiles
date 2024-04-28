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
      profiles."0" = {
        name = "0";
        isDefault = true;
        id = 0;
        search.default = "Google"; # i need calculator

        # Extensions
        extensions = with config.nur.repos.rycee.firefox-addons; [
          ublock-origin
          keepa
          auto-tab-discard
          youtube-recommended-videos
        ];

        userChrome = ''
          @-moz-document url(chrome://browser/content/browser.xhtml){

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
        '';
      };
    };
  };
}
