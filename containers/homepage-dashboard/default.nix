{
  lib,
  config,
  ...
}: {
  options.container.homepage-dashboard.enable = lib.mkEnableOption "";

  config = lib.mkIf config.container.homepage-dashboard.enable {

    containers.homepage-dashboard = {
      autoStart = true;
      privateNetwork = true;
      
      services.homepage-dashboard = {
        enable = true;
        listenPort = 80;
      };

      networking = {
        firewall = {
          enable = true;
          allowedTCPPorts = [ 80 ];
        };
        useHostResolvConf = lib.mkForce false;
      };

      services.resolved.enable = true;
    };
  };
}