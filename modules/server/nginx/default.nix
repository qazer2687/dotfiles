{ lib, config, ... }: 
let
  domain = "qazer.org";
  subdomains = [ "grafana" "pihole" "dashboard" "prometheus" "portainer" "node-exporter" "cockpit" "nextcloud" ];
in {
  options.modules.server.nginx.enable = lib.mkEnableOption "nginx with ACME";

  config = lib.mkIf config.modules.server.nginx.enable {
    # Open ports
    networking.firewall.allowedTCPPorts = [ 80 443 ];

    # ACME Certificates
    security.acme = {
      acceptTerms = true;
      defaults.email = "qazer2687@gmail.com";
      certs = lib.genAttrs 
        (map (sub: "${sub}.${domain}") subdomains) 
        (domain: { 
          webroot = "/var/www/acme";
          extraDomainNames = [ domain ]; 
        });
    };

    # Nginx Configuration
    services.nginx = {
      enable = true;
      virtualHosts = lib.genAttrs 
        (map (sub: "${sub}.${domain}") subdomains) 
        (sub: {
          forceSSL = true;
          enableACME = true;
          locations."/" = {
            proxyPass = "http://127.0.0.1:${
              {
                "grafana" = "3000";
                "pihole" = "3001";
                "dashboard" = "8082";
                "prometheus" = "9090";
                "portainer" = "9443";
                "node-exporter" = "9100";
                "cockpit" = "10000";
                "nextcloud" = "11000";
              }.${sub}
            }/";
          };
        });
    };
  };
}