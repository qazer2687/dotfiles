{
  lib,
  config,
  ...
}: {
  options.homeModules.firefox.enable = lib.mkEnableOption "";

  config = lib.mkIf config.homeModules.firefox.enable {
    programs.firefox = {
      enable = true;
      profiles.custom = {
        name = "custom";
        isDefault = true;
        #userChrome = builtins.readFile ./config/jade;
        settings = {
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        };
      };
    };
  };
}
