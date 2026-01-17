{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: {
  options.modules.firefox.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.firefox.enable {
    textfox = {
      enable = false;
      profile = "default";
      config = {
        font.family = "PragmataPro";
        displayTitles = false;
        displaySidebarTools = false;
      };
    };

    programs.firefox = {
      enable = true;
      package = pkgs.firefox;

      profiles."default" = {
        name = "default";
        isDefault = true;
        id = 0;

        #userChrome = builtins.readFile ./config/userChrome.css;
        extraConfig = builtins.readFile ./config/betterfox.js + builtins.readFile ./config/custom.js;
      };
    };
  };
}
