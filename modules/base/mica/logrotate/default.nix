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

      paths = {
        # System Logs
        "/var/log/messages" = {
          rotate = 8;
        };
        
        # Security Logs
        "/var/log/auth.log" = {
          frequency = "daily";
          rotate = 30;
          size = "10M";
        };
        
        # Kernel Logs
        "/var/log/kern.log" = {
          rotate = 4;
        };

        # TODO - Add docker logs.
      };
    };
  };
}
