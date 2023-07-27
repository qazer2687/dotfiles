{
  lib,
  config,
  ...
}: {
  options.homeModules.programs.udiskie.enable = lib.mkEnableOption "";

  config = lib.mkIf config.homeModules.programs.udiskie.enable {
    services.udiskie = {
      enable = true;
      notify = true;
    };
  };
}
