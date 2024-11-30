{
  lib,
  config,
  inputs,
  pkgs,
  ...
}: {

  options.modules.server.caddy.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.server.caddy.enable {
    networking.firewall.allowedTCPPorts = [ 80 443 ];

    sops.secrets.cloudflare-api-token = {};

    services.caddy = {
      enable = true;
      package = pkgs.xcaddy;
      virtualHosts."grafana.qazer.org".extraConfig = ''
        reverse_proxy http://127.0.0.1:3000
        tls {
          dns cloudflare ${builtins.readFile /run/secrets/cloudflare-api-token}
        }
      '';
      virtualHosts."pihole.qazer.org".extraConfig = ''
        reverse_proxy http://127.0.0.1:3001
        tls {
          dns cloudflare ${builtins.readFile /run/secrets/cloudflare-api-token}
        }
      '';
      virtualHosts."dashboard.qazer.org".extraConfig = ''
        reverse_proxy http://127.0.0.1:8082
        tls {
          dns cloudflare ${builtins.readFile /run/secrets/cloudflare-api-token}
        }
      '';
      virtualHosts."prometheus.qazer.org".extraConfig = ''
        reverse_proxy http://127.0.0.1:9090
        tls {
          dns cloudflare ${builtins.readFile /run/secrets/cloudflare-api-token}
        }
      '';
      virtualHosts."portainer.qazer.org".extraConfig = ''
        reverse_proxy http://127.0.0.1:9443
        tls {
          dns cloudflare ${builtins.readFile /run/secrets/cloudflare-api-token}
        }
      '';
      virtualHosts."node-exporter.qazer.org".extraConfig = ''
        reverse_proxy http://127.0.0.1:9100
        tls {
          dns cloudflare ${builtins.readFile /run/secrets/cloudflare-api-token}
        }
      '';
      virtualHosts."cockpit.qazer.org".extraConfig = ''
        reverse_proxy http://127.0.0.1:10000
        tls {
          dns cloudflare ${builtins.readFile /run/secrets/cloudflare-api-token}
        }
      '';
      virtualHosts."nextcloud.qazer.org".extraConfig = ''
        reverse_proxy http://127.0.0.1:11000
        tls {
          dns cloudflare ${builtins.readFile /run/secrets/cloudflare-api-token}
        }
      '';
    };
  };
}
