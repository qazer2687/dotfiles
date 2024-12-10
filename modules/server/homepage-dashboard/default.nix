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
        title = "Dashboard";
        startURL = "https://dashboard.qazer.org";
        theme = "dark";
        background = "https://i.imgur.com/GgtJC5a.jpeg";
        color = "slate";
        hideVersion = "true";
        showStats = "true";
        statusStyle = "basic";

        layout = {
          Bookmarks = {
            style = "column";
            header = "true";
            rows = "4";
          };
        };
      };

      

      docker = {
        opal = {
          host = "127.0.0.1";
          port = "2376";
        };
      };

      widgets = [
        /*{
          greeting = {
            text = "Qazer's Homelab Dashboard";
          };
        }*/
        {
          resources = {
            cpu = true;
            memory = true;
            disk = "/";
            cputemp = true;
            tempmin = 0;
            tempmax = 100;
            uptime = true;
            units = "metric";
            refresh = 3000;
            diskUnits = "bytes";
          };
        }
      ];

      bookmarks = [
        {
          "Bookmarks" = [
            {
              "Cloudflare" = [{
                href = "https://dash.cloudflare.com";
                icon = "sh-cloudflare";
              }];
            }
            {
              "Tailscale" = [{
                href = "https://login.tailscale.com/admin/machines";
                icon = "sh-tailscale";
              }];
            }
          ];  
        }
      ];

      services = [
        {
          "Networking" = [
            {
              "Pihole" = {
                description = "DNS Server";
                href = "https://pihole.qazer.org";
                server = "opal";
                container = "pihole";
                icon = "sh-pi-hole";
              };
            }
            {
              "Nginx Proxy Manager" = {
                description = "SSL & Proxy";
                href = "https://pihole.qazer.org";
                server = "opal";
                container = "pihole";
                icon = "sh-nginx-proxy-manager";
              };
            }
          ];
        }
        {
          "Monitoring" = [
            {
              "Grafana" = {
                description = "Observability Platform";
                href = "https://grafana.qazer.org";
                server = "opal";
                container = "grafana";
                icon = "sh-grafana";
              };
            }
            {
              "Prometheus" = {
                description = "Monitoring System";
                href = "https://prometheus.qazer.org";
                server = "opal";
                container = "prometheus";
                icon = "sh-prometheus";
              };
            }
            {
              "Portainer" = {
                description = "Container Management";
                # Needs to use HTTPS.
                href = "https://portainer.qazer.org";
                server = "opal";
                container = "portainer";
                icon = "sh-portainer";
              };
            }
          ];
        }
        {
          "Media/Storage" = [
            {
              "Nextcloud" = {
                description = "Cloud Storage";
                href = "https://nextcloud.qazer.org";
                server = "opal";
                container = "nextcloud";
                icon = "sh-nextcloud";
              };
            }
            {
              "Immich" = {
                description = "Photo & Video Management";
                server = "opal";
                container = "immich_server";
                icon = "sh-immich";
              };
            }
          ];
        }
      ];
    };
  };
}
