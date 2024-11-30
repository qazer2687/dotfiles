{ lib, config, ... }: let

  cloudflare-api-token = builtins.readFile ${config.sops.secrets.cloudflare-api-token.path};
  cloudflare-email = builtins.readFile ${config.sops.secrets.cloudflare-email.path};

in {
  options.modules.server.nginx.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.server.nginx.enable {
    networking.firewall.allowedTCPPorts = [ 80 443 ];

    security.acme = {
      acceptTerms = true;
      defaults.email = "qazer2687@gmail.com";
      
      certs = {
        "*.qazer.org" = {
          dnsChallenge = {
            provider = "cloudflare";
            apiKey = cloudflare-api-token;
            email = cloudflare-email;
          };
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