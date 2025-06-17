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
      package = pkgs.firefox;
      
      profiles."default" = {
        name = "default";
        isDefault = true;
        id = 0;

        # I don't have NUR as an input currently,
        # I can just install these manually.
        /*
        extensions = with pkgs.nur.repos.rycee.firefox-addons; [
          ublock-origin
          keepa
          return-youtube-dislikes
          sponsorblock
        ];
        */

        userChrome = ''
          * {
            font-family: "DepartureMono", sans-serif !important;
          }
          
          /* search and tabs on the same line */
          .titlebar-buttonbox,.titlebar-spacer,#back-button,#forward-button,#tracking-protection-icon-container,#page-action-buttons,#PanelUI-button{display:none!important}#navigator-toolbox{border:0!important}#TabsToolbar{margin-left:20vw!important}#nav-bar{background:transparent!important;margin-right:80vw!important;margin-top:-36px!important}#urlbar-container{width:auto!important}#urlbar{background:transparent!important;border:none!important;box-shadow:none!important}#urlbar[breakout-extend]{width:100vw!important}
        '';

        extraConfig = builtins.readFile ./config/user.js;
      };
    };

    # Asahi Widevine Support
    # Note that in order for Netflix to work, this needs to be paried with
    # a web user-agent spoofer configured to emulate Chrome on ChromeOS.
    home.file."firefox-widevinecdm" = lib.mkIf pkgs.stdenv.hostPlatform.isAarch64 {
      enable = true;
      target = ".mozilla/firefox/default/gmp-widevinecdm";
      source = pkgs.runCommandLocal "firefox-widevinecdm" {} ''
        out=$out/${pkgs.widevinecdm-aarch64.version}
        mkdir -p $out
        ln -s ${pkgs.widevinecdm-aarch64}/manifest.json $out/manifest.json
        ln -s ${pkgs.widevinecdm-aarch64}/libwidevinecdm.so $out/libwidevinecdm.so
      '';
      recursive = true;
    };
    programs.firefox.profiles."default".settings = lib.mkIf pkgs.stdenv.hostPlatform.isAarch64 {
      "media.gmp-widevinecdm.version" = pkgs.widevinecdm-aarch64.version;
      "media.gmp-widevinecdm.visible" = true;
      "media.gmp-widevinecdm.enabled" = true;
      "media.gmp-widevinecdm.autoupdate" = false;
      "media.eme.enabled" = true;
      "media.eme.encrypted-media-encryption-scheme.enabled" = true;
    };
  };
}
