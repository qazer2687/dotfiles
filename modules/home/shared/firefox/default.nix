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

        #userChrome = builtins.readFile ./config/userChrome.css;
        extraConfig = builtins.readFile ./config/betterfox_.js + builtins.readFile ./config/custom.js;
      };
    };

    # Widevine/DRM Support
    home.sessionVariables = lib.mkIf pkgs.stdenv.hostPlatform.isAarch64 {
      MOZ_GMP_PATH = "${pkgs.widevine}/gmp-widevinecdm/system-installed";
    };
    programs.firefox.profiles."default".settings = lib.mkIf pkgs.stdenv.hostPlatform.isAarch64 {
      "media.gmp-widevinecdm.version" = "system-installed";
      "media.gmp-widevinecdm.visible" = true;
      "media.gmp-widevinecdm.enabled" = true;
      "media.gmp-widevinecdm.autoupdate" = false;

      "media.eme.enabled" = true;
      "media.eme.encrypted-media-encryption-scheme.enabled" = true;
    };
  };
}
