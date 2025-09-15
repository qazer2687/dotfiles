{
  lib,
  config,
  pkgs,
  ...
}: {
  options.modules.firefox.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.firefox.enable {
    textfox = {
      enable = true;
      profile = "default";
      config = {
        font.family = "TX02";
        displayTitles = false;
        displaySidebarTools = true;
      };
    };

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

        #userChrome = builtins.readFile ./config/userChrome.css;
        extraConfig = builtins.readFile ./config/betterfox.js + builtins.readFile ./config/custom.js;
      };
    };

    # Widevine/DRM Support
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
