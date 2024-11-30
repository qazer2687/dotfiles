{
  lib,
  config,
  inputs,
  ...
}: {

  options.modules.server.caddy.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.server.caddy.enable {
    networking.firewall.allowedTCPPorts = [ 80 443 ];

    sops.secrets.cloudflare-api-token = {};

    systemd.services.caddy = {
      serviceConfig = {
        EnvironmentFile = config.sops.secrets.cloudflare-api-token.path;
      };
    };

    services.caddy = {
      enable = true;
      globalConfig = ''
        (cloudflare) {
          tls {
            dns cloudflare {env.cloudflare-api-token}
          }
        }
      '';
      virtualHosts."grafana.qazer.org".extraConfig = ''
        reverse_proxy http://127.0.0.1:3000
        import cloudflare
      '';
      virtualHosts."pihole.qazer.org".extraConfig = ''
        reverse_proxy http://127.0.0.1:3001
        import cloudflare
      '';
      virtualHosts."dashboard.qazer.org".extraConfig = ''
        reverse_proxy http://127.0.0.1:8082
        import cloudflare
      '';
      virtualHosts."prometheus.qazer.org".extraConfig = ''
        reverse_proxy http://127.0.0.1:9090
        import cloudflare
      '';
      virtualHosts."portainer.qazer.org".extraConfig = ''
        reverse_proxy http://127.0.0.1:9443
        import cloudflare
      '';
      virtualHosts."node-exporter.qazer.org".extraConfig = ''
        reverse_proxy http://127.0.0.1:9100
        import cloudflare
      '';
      virtualHosts."cockpit.qazer.org".extraConfig = ''
        reverse_proxy http://127.0.0.1:10000
        import cloudflare
      '';
      virtualHosts."nextcloud.qazer.org".extraConfig = ''
        reverse_proxy http://127.0.0.1:11000
        import cloudflare
      '';
    };
  };
}
