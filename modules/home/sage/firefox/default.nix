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
        extraConfig = builtins.readFile ./config/betterfox.js + builtins.readFile ./config/custom.js;
      };
    };
  };
}
