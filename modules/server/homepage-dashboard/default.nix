{
  lib,
  config,
  ...
}: {
  options.modules.server.homepage-dashboard.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.server.homepage-dashboard.enable {
    services.homepage-dashboard = {
      enable = true;
      listenPort = 8082;
      settings = {
        title = "dashboard.qazer.org";
        startURL = "https://dashboard.qazer.org";
        theme = "dark";
        background = "https://images.unsplash.com/photo-1603366615917-1fa6dad5c4fa?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D";
        color = "slate";
        hideVersion = "true";

      };
      widgets = [
        {
          greeting = {
            text = "Qazer's Homelab Dashboard";
          };
        }
        {
          openmeteo = {
            latitude = "51.5072";
            longitude = "0.1276";
            timezone = "Europe/London";
            units = "metric";
            cache = 15;
          };
        }
      ];

      docker = {
        opal = {
          host = "127.0.0.1";
          port = "2376";
        };
      };

      services = [
        {
          "Links" = [
            {
              "Cloudflare" = {
                description = "CDN, DNS & DDoS Protection";
                href = "https://dash.cloudflare.com";
                icon = "sh-cloudflare";
              };
            }
            {
              "Tailscale" = {
                description = "VPN Service";
                href = "https://login.tailscale.com/admin/machines";
                icon = "sh-tailscale";
              };
            }
          ];

          "Services" = [
            {
              "Grafana" = {
                description = "Observability Platform";
                href = "http://grafana.qazer.org/";
                server = "opal";
                container = "grafana";
                icon = "sh-grafana";
              };
            }
            {
              "Prometheus" = {
                description = "Monitoring System";
                href = "http://prometheus.qazer.org/";
                server = "opal";
                container = "prometheus";
                icon = "sh-prometheus";
              };
            }
            {
              "Portainer" = {
                description = "Container Management";
                # Needs to use HTTPS.
                href = "https://portainer.qazer.org/";
                server = "opal";
                container = "portainer";
                icon = "sh-portainer";
              };
            }
            {
              "Pihole" = {
                description = "DNS Server";
                href = "http://pihole.qazer.org/";
                server = "opal";
                container = "pihole";
                icon = "sh-pi-hole";
              };
            }
          ];
        }
      ];
    };
  };
}
