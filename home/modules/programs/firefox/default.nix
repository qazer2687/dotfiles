{
  lib,
  config,
  ...
}: {
  options.homeModules.programs.firefox.enable = lib.mkEnableOption "";

  config = lib.mkIf config.homeModules.programs.firefox.enable {
    programs.firefox = {
      enable = true;
      profiles.custom = {
        isDefault = true;
        name = "custom";
        userChrome = builtins.readFile ./userChrome.css;
        settings = {
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        };
      };
    };
  };
}