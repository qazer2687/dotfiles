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

    #sops.secrets.cloudflare-api-token = {};

    # tls {
    #  dns cloudflare ${builtins.readFile /run/secrets/cloudflare-api-token}
    # }

    services.caddy = {
      enable = true;
      extraConfig = ''
        :80 {
          tls off
        }
      '';
      virtualHosts."grafana.qazer.org".extraConfig = ''
        reverse_proxy http://127.0.0.1:3000
      '';
      virtualHosts."pihole.qazer.org".extraConfig = ''
        reverse_proxy http://127.0.0.1:3001
      '';
      virtualHosts."dashboard.qazer.org".extraConfig = ''
        reverse_proxy http://127.0.0.1:8082
      '';
      virtualHosts."prometheus.qazer.org".extraConfig = ''
        reverse_proxy http://127.0.0.1:9090
      '';
      virtualHosts."portainer.qazer.org".extraConfig = ''
        reverse_proxy http://127.0.0.1:9443
      '';
      virtualHosts."node-exporter.qazer.org".extraConfig = ''
        reverse_proxy http://127.0.0.1:9100
      '';
      virtualHosts."cockpit.qazer.org".extraConfig = ''
        reverse_proxy http://127.0.0.1:10000
      '';
      virtualHosts."nextcloud.qazer.org".extraConfig = ''
        reverse_proxy http://127.0.0.1:11000
      '';
    };
  };
}
