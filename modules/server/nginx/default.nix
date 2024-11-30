{ lib, config, ... }: 
let
  domain = "qazer.org";

  # Unified function for creating certificates and reverse proxies
  mkService = sub: port: let
    fullDomain = if sub == "" then domain else "${sub}.${domain}";
  in {
    # ACME Certificate Configuration
    security.acme.certs."${fullDomain}" = {
      domain = fullDomain;
      webroot = "/var/www/acme";
    };

    # Nginx Virtual Host Configuration
    services.nginx.virtualHosts."${fullDomain}" = {
      listen = [ "443 ssl" "80" ];
      sslCertificate = "/var/lib/acme/${fullDomain}/fullchain.pem";
      sslCertificateKey = "/var/lib/acme/${fullDomain}/privkey.pem";
      locations."/" = {
        proxyPass = "http://127.0.0.1:${port}/";
      };
    };
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
    };

    # Nginx Service Configuration
    services.nginx = {
      enable = true;
      clientMaxBodySize = "0";
      recommendedProxySettings = true;
      recommendedOptimisation = true;
    };

    # Combine certificate and virtual host configurations
    # Using lib.mkMerge to combine multiple service configurations
    services.nginx.virtualHosts = lib.mkMerge [
      (mkService "grafana" "3000")
      (mkService "pihole" "3001")
      (mkService "dashboard" "8082")
      (mkService "prometheus" "9090")
      (mkService "portainer" "9443")
      (mkService "node-exporter" "9100")
      (mkService "cockpit" "10000")
      (mkService "nextcloud" "11000")
    ];
  };
}