{ lib, config, ... }: 
let
  domain = "qazer.org";

  # Services configuration
  services = {
    grafana = 3000;
    pihole = 3001;
    dashboard = 8082;
    prometheus = 9090;
    portainer = 9443;
    "node-exporter" = 9100;
    cockpit = 10000;
    nextcloud = 11000;
  };
in {
  options.modules.server.nginx.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.server.nginx.enable {
    # Open firewall ports
    networking.firewall.allowedTCPPorts = [ 80 443 ];

    # Global ACME Configuration
    security.acme = {
      acceptTerms = true;
      defaults = {
        email = "qazer2687@gmail.com";
        webroot = "/var/www/acme";
      };
      
      # Generate certificates for each service
      certs = lib.mapAttrs' (sub: port: 
        lib.nameValuePair 
          "${sub}.${domain}" 
          { domain = "${sub}.${domain}"; }
      ) services;
    };

    # Nginx Service Configuration
    services.nginx = {
      enable = true;
      clientMaxBodySize = "0";
      recommendedProxySettings = true;
      recommendedOptimisation = true;

      # Virtual hosts for each service
      virtualHosts = lib.mapAttrs' (sub: port: 
        lib.nameValuePair 
          "${sub}.${domain}" 
          {
            forceSSL = true;
            enableACME = true;
            locations."/" = {
              proxyPass = "http://127.0.0.1:${toString port}/";
            };
          }
      ) services;
    };
  };
}