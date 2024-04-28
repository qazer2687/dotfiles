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
          #search-container {
            position: fixed !important;
            bottom: 0 !important;
            width: 100% !important;
            z-index: 9999 !important;
          }
        '';
      };
    };
  };
}
