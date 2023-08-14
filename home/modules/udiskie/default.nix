{
  lib,
  config,
  ...
}: {
  options.homeModules.udiskie.enable = lib.mkEnableOption "";

  config = lib.mkIf config.homeModules.udiskie.enable {
    services.udiskie = {
      enable = true;
      notify = true;
    };
  };
}
