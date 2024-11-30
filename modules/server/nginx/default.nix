{ lib, config, ... }: let
  domain = "qazer.org";

  # Function to create virtualHosts with SSL and ACME configuration
  mkRP = sub: port: let
    dom = if sub == "" then domain else "${sub}.${domain}";
  in {
    security.acme.certs."${dom}" = {
      domain = dom;
      webroot = "/var/www/acme";
    };

    services.nginx.virtualHosts."${dom}" = {
      listen = [ "443 ssl" "80" ];
      sslCertificate = "/var/lib/acme/${dom}/fullchain.pem";
      sslCertificateKey = "/var/lib/acme/${dom}/privkey.pem";
      locations."/" = {
        proxyPass = "https://127.0.0.1:${port}/";
      };
    };
  };
in {
  options.modules.server.nginx.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.server.nginx.enable {
    networking.firewall.allowedTCPPorts = [ 80 443 ];

    security.acme = {
      acceptTerms = true;

      defaults = {
        email = "qazer2687@gmail.com"; # TODO: Use SOPS for email.
        webroot = "/var/www/acme";
      };
    };

    services.nginx = {
      enable = true;
      clientMaxBodySize = "0";
      recommendedProxySettings = true;
      recommendedOptimisation = true;

      virtualHosts = lib.mkMerge [
        (mkRP "grafana" "3000")
        (mkRP "pihole" "3001")
        (mkRP "dashboard" "8082")
        (mkRP "prometheus" "9090")
        (mkRP "portainer" "9443")
        (mkRP "node-exporter" "9100")
        (mkRP "cockpit" "10000")
        (mkRP "nextcloud" "11000")
      ];
    };
  };
}
