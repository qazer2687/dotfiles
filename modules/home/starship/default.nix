{
  lib,
  config,
  ...
}: {
  options.modules.starship.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.starship.enable {
    programs.starship = {
      enable = true;
      enableBashIntegration = true;
    };
  };
}
