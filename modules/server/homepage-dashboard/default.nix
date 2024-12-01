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
        background = "https://imgur.com/GgtJC5a";
        color = "slate";
        hideVersion = "true";
        showStats = "true";
        #statusStyle = "dot";
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
          "Bookmarks" = {
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
          };  
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
              "Nextcloud MariaDB" = {
                description = "Database Management System";
                server = "opal";
                container = "nextcloud-mariadb";
                icon = "sh-mariadb";
              };
            }
            {
              "Nextcloud Redis" = {
                description = "Database Cache";
                server = "opal";
                container = "nextcloud-redis";
                icon = "sh-redis";
              };
            }
          ];
        }
      ];
    };
  };
}
