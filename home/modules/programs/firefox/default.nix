{
  lib,
  config,
  inputs,
  ...
}: {
  options.homeModules.programs.firefox.enable = lib.mkEnableOption "";

  config = lib.mkIf config.homeModules.programs.firefox.enable {
    programs.firefox = {
      enable = true;
      profiles.custom = {
        name = "custom";
        isDefault = true;
        #userChrome = builtins.readFile ./userChrome.css;
        settings = {
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        };
        extensions = with inputs.nur.repos.rycee.firefox-addons; [
          ublock-origin
          decentraleyes
          catpuccin-mocha-rosewater
        ];
      };
    };
  };
}