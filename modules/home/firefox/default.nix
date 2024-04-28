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
        extensions = with pkgs.nur.repos.rycee.firefox-addons; [
          ublock-origin
          keepa
          auto-tab-discard
          youtube-recommended-videos
        ];

        userChrome = ''
          @-moz-document url(chrome://browser/content/browser.xhtml){

            :root:not([inDOMFullscreen]){
              --uc-vertical-toolbar-width: 60px;
            }
            #navigator-toolbox{ position: relative }
            #PersonalToolbar{
              position: absolute;
              display: flex;
              flex-direction: column;
              top: 100%;
              left: 0;
              width: var(--uc-vertical-toolbar-width,0);
              min-width: unset !important;
              /* These create a empty area to the bottom of the toolbar, which is to mask a fact that we don't know exactly how high the toolbar should be */
              height: 100vh;
              max-height: 100vh !important; 
              padding-bottom: 120px !important;
              padding-inline: 2px !important;
            }
            #PersonalToolbar .toolbarbutton-1{
              --toolbarbutton-inner-padding: 10px !important;
            }
            #PersonalToolbar #PlacesChevron{
              display: none;
            }
            #PersonalToolbar > #personal-bookmarks{
              overflow-y: auto;
              scrollbar-width: none;
              height: 100vh;
            }
            
            #PlacesToolbar,
            #PlacesToolbarDropIndicatorHolder{
              -moz-box-orient: vertical !important; /* Can be removed with Firefox 112 */
              flex-direction: column;
            }
            
            #PersonalToolbar #PlacesToolbarItems{
              display: flex !important;
              flex-direction: column;
              overflow-y: auto;
              scrollbar-width: none;
            }
            #PersonalToolbar > toolbaritem{
              justify-content: center;
            }
            #PersonalToolbar #PlacesToolbarItems > toolbarseparator{
              height: 7px;
              background-color: currentColor;
              background-clip: padding-box;
              border-block: 3px solid transparent !important;
            }

            #PersonalToolbar #PlacesToolbarItems > .bookmark-item{
              padding-block: 4px !important;
              margin-inline: 0 !important;
            }
            
            #browser,
            #browser-bottombox,
            #main-window > body::after, /* This selector is for compatibility with tabs_below_content.css */
            #customization-container{
              margin-left: var(--uc-vertical-toolbar-width,0);
            }
            :root:is([chromehidden~="toolbar"],[sizemode="fullscreen"]) > body > #browser,
            :root:is([chromehidden~="toolbar"],[sizemode="fullscreen"]) > body > #browser-bottombox,
            #main-window:is([chromehidden~="toolbar"],[sizemode="fullscreen"]) > body::after,
            :root:is([chromehidden~="toolbar"],[sizemode="fullscreen"]) > body > #customization-container{
              margin-left: 0;
            }
            /* You should probably disable this if you have Firefox < 113 */
            #PersonalToolbar #PlacesToolbarItems{
              display: -webkit-box !important;
              -webkit-box-orient: vertical !important;
            }
          }
        '';
      };
    };
  };
}
