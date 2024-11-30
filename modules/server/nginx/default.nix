{
  lib,
  config,
  ...
}: let
  domain = "qazer.org";
  # Function to create virtualHosts.
  mkRP =
    sub: port:
    let
      dom = if sub == "" then domain else "${sub}.${domain}";
    in {
      "${dom}" = {
        locations."/" = {
          proxyPass = "https://127.0.0.1:${port}/";
        };
        listen = [ "443 ssl" "80" ];
        sslCertificate = "/etc/letsencrypt/live/${dom}/fullchain.pem";
        sslCertificateKey = "/etc/letsencrypt/live/${dom}/privkey.pem";
      };
    };
in {

  # Cloudflare DNS Configuration
  # A - @ -> 100.100.101.66
  # A - *.qazer.org -> 100.100.101.66

  options.modules.server.nginx.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.server.nginx.enable {
    networking.firewall.allowedTCPPorts = [ 80 443 ];

    services.certbot = {
      enable = true;
      email = "qazer2687@gmail.com";  # TODO: Replace with SOPS email.
      domains = [ qazer.org ];
    };

    services.nginx = {
      enable = true;
      # Disables checking body size, allowing nextcloud to recieve large files.
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
