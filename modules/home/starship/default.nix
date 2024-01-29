{
  lib,
  config,
  ...
}: {
  options.homeModules.starship.enable = lib.mkEnableOption "";

  config = lib.mkIf config.homeModules.starship.enable {
    programs.starship = {
      enable = true;
      enableBashIntegration = true;
    };
  };
}
