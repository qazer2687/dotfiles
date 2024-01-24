{
  lib,
  config,
  pkgs,
  ...
}: {
  options.container.homepage-dashboard.enable = lib.mkEnableOption "";

  config = lib.mkIf config.container.homepage-dashboard.enable {

    containers.homepage-dashboard = {
      autoStart = true;

      bindMounts = {
        "/var/lib/homepage-dashboard" = {
          hostPath = "/home/alex/.config/homepage-dashboard";
          isReadOnly = false;
        };
      };
      
      config = { config, pkgs, lib, ... }: {

        system.stateVersion = "24.05";
      
        services.homepage-dashboard = {
          enable = true;
          listenPort = 80;
          package = pkgs.homepage-dashboard;
        };

        networking = {
          firewall = {
            enable = true;
            allowedTCPPorts = [ 80 3000 ];
          };
          useHostResolvConf = lib.mkForce false;
        };

        services.resolved.enable = true;
      };
    };
  };
}