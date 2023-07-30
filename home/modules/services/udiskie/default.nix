{
  lib,
  config,
  ...
}: {
  options.homeModules.services.udiskie.enable = lib.mkEnableOption "";

  config = lib.mkIf config.homeModules.services.udiskie.enable {
    services.udiskie = {
      enable = true;
      notify = true;
    };
  };
}
