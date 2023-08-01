{
  lib,
  config,
  ...
}: {
  options.homeModules.programs.firefox.enable = lib.mkEnableOption "";

  config = lib.mkIf config.homeModules.programs.firefox.enable {
    programs.firefox = {
      enable = true;
      profiles.custom.isDefault = true;
      profiles.custom.name = "custom";
      profiles.custom.userChrome = builtins.readFile ./userChrome.css;
    };
  };
}
