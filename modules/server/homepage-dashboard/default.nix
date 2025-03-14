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
        #background = "https://i.imgur.com/GgtJC5a.jpeg";
        color = "slate";
        hideVersion = "true";
        showStats = "true";
        statusStyle = "basic"; # dot / basic
        headerStyle = "boxedWidgets";

        layout = {
          Bookmarks = {
            style = "row";
            header = false;
            columns = "2";
          };
          Networking = {
            style = "column";
            header = true;
            rows = "4";
          };
          Monitoring = {
            style = "column";
            header = true;
            rows = "4";
          };
          Media = {
            style = "column";
            header = true;
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
        /*
        {
          greeting = {
            text = "Qazer's Dashboard";
          };
        }
        */
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
            refresh = 15000;
            diskUnits = "bytes";
          };
        }
      ];

      bookmarks = [
        {
          "Bookmarks" = [
            {
              "Cloudflare" = [
                {
                  href = "https://dash.cloudflare.com";
                  icon = "sh-cloudflare";
                }
              ];
            }
            {
              "Tailscale" = [
                {
                  href = "https://login.tailscale.com/admin/machines";
                  icon = "sh-tailscale";
                }
              ];
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
              "Fail2Ban" = {
                description = "Malicious IP Blocking";
                server = "opal";
                container = "fail2ban";
                icon = "sh-fail2ban";
              };
            }
            {
              "DDClient" = {
                description = "Dynamic DNS";
                server = "opal";
                container = "ddclient";
                icon = "sh-ddclient";
              };
            }
            {
              "Caddy" = {
                description = "SSL & Proxy";
                server = "opal";
                container = "caddy";
                icon = "sh-caddy";
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
                href = "https://portainer.qazer.org";
                server = "opal";
                container = "portainer";
                icon = "sh-portainer";
              };
            }
            {
              "cAdvisor" = {
                description = "Container Analyzer";
                server = "opal";
                container = "cadvisor";
                icon = "sh-cadvisor";
              };
            }
          ];
        }
        {
          "Media" = [
            /*
            {
              "Nextcloud" = {
                description = "Cloud Storage";
                href = "https://nextcloud.qazer.org";
                #server = "opal";
                #container = "nextcloud";
                icon = "sh-nextcloud";
              };
            }
            */
            {
              "Immich" = {
                description = "Photo & Video Management";
                server = "opal";
                container = "immich_server";
                icon = "sh-immich";
              };
            }
            {
              "Code" = {
                description = "Visual Studio Code Server";
                server = "opal";
                container = "code-server";
                icon = "sh-visual-studio-code";
                href = "https://code.qazer.org";
              };
            }
            {
              "Mumble" = {
                description = "Voice Chat";
                server = "opal";
                container = "mumble";
                icon = "sh-mumble";
              };
            }
            {
              "Conduwuit" = {
                description = "Matrix Homeserver";
                server = "opal";
                container = "conduwuit";
                icon = "sh-conduwuit";
              };
            }
          ];
        }
      ];
    };
  };
}
