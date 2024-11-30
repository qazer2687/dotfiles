{ lib, config, ... }: 
{
  options.modules.server.nginx.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.server.nginx.enable {
    # Open firewall ports
    networking.firewall.allowedTCPPorts = [ 80 443 ];

    # Global ACME Configuration
    security.acme = {
      acceptTerms = true;
      defaults.email = "qazer2687@gmail.com";
    };

    # Nginx Service Configuration
    services.nginx = {
      enable = true;
      virtualHosts = {
        "grafana.qazer.org" = {
          forceSSL = true;
          enableACME = true;
          locations."/" = {
            proxyPass = "http://127.0.0.1:3000/";
          };
        };
        "pihole.qazer.org" = {
          forceSSL = true;
          enableACME = true;
          locations."/" = {
            proxyPass = "http://127.0.0.1:3001/";
          };
        };
        "dashboard.qazer.org" = {
          forceSSL = true;
          enableACME = true;
          locations."/" = {
            proxyPass = "http://127.0.0.1:8082/";
          };
        };
        "prometheus.qazer.org" = {
          forceSSL = true;
          enableACME = true;
          locations."/" = {
            proxyPass = "http://127.0.0.1:9090/";
          };
        };
        "portainer.qazer.org" = {
          forceSSL = true;
          enableACME = true;
          locations."/" = {
            proxyPass = "http://127.0.0.1:9443/";
          };
        };
        "node-exporter.qazer.org" = {
          forceSSL = true;
          enableACME = true;
          locations."/" = {
            proxyPass = "http://127.0.0.1:9100/";
          };
        };
        "cockpit.qazer.org" = {
          forceSSL = true;
          enableACME = true;
          locations."/" = {
            proxyPass = "http://127.0.0.1:10000/";
          };
        };
        "nextcloud.qazer.org" = {
          forceSSL = true;
          enableACME = true;
          locations."/" = {
            proxyPass = "http://127.0.0.1:11000/";
          };
        };
      };
    };
  };
}