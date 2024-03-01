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
        search.default = "DuckDuckGo";

        # Arkenfox
        arkenfox = {
          enable = true;
          version = "122.0";
        };

        # Extensions
        extensions = with pkgs.nur.repos.rycee.firefox-addons; [
          ublock-origin
          keepa
          auto-tab-discard
        ];
      };
    };
  };
}

