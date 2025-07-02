{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: {
  options.modules.logrotate.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.logrotate.enable {
    services.logrotate = {
      enable = true;
      
      settings = {
        frequency = "weekly";
        rotate = 4;

        compress = true;
        delaycompress = true;

        notifempty = true;

        missingok = true;
        
        dateext = true;
      };
    };
  };
}
