{
  lib,
  config,
  ...
}: {
  options.modules.logrotate.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.logrotate.enable {
    services.logrotate = {
      enable = true;
    };
  };
}
