{ lib, config, ... }:
{
  options.modules.server.nginx.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.server.nginx.enable {
    networking.firewall.allowedTCPPorts = [ 80 443 ];

    security.acme = {
      acceptTerms = true;
      defaults.email = "qazer2687@gmail.com";
      
      certs = {
        "grafana.qazer.org" = {
          webroot = "/var/www/acme-challenge";
          extraDomainNames = [ "grafana.qazer.org" ];
        };
        "pihole.qazer.org" = {
          webroot = "/var/www/acme-challenge";
          extraDomainNames = [ "pihole.qazer.org" ];
        };
        "dashboard.qazer.org" = {
          webroot = "/var/www/acme-challenge";
          extraDomainNames = [ "dashboard.qazer.org" ];
        };
        "prometheus.qazer.org" = {
          webroot = "/var/www/acme-challenge";
          extraDomainNames = [ "prometheus.qazer.org" ];
        };
        "portainer.qazer.org" = {
          webroot = "/var/www/acme-challenge";
          extraDomainNames = [ "portainer.qazer.org" ];
        };
        "node-exporter.qazer.org" = {
          webroot = "/var/www/acme-challenge";
          extraDomainNames = [ "node-exporter.qazer.org" ];
        };
        "cockpit.qazer.org" = {
          webroot = "/var/www/acme-challenge";
          extraDomainNames = [ "cockpit.qazer.org" ];
        };
        "nextcloud.qazer.org" = {
          webroot = "/var/www/acme-challenge";
          extraDomainNames = [ "nextcloud.qazer.org" ];
        };
      };
    };

    services.nginx = {
      enable = true;
      clientMaxBodySize = "0";
      recommendedProxySettings = true;
      recommendedOptimisation = true;
      
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

    # Ensure ACME challenge directory exists
    systemd.tmpfiles.rules = [
      "d /var/www/acme-challenge 0755 acme nginx -"
      "d /var/www/acme-challenge/.well-known 0755 acme nginx -"
      "d /var/www/acme-challenge/.well-known/acme-challenge 0755 acme nginx -"
    ];
  };
}