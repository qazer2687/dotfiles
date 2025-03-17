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
        background = "https://preview.redd.it/7680-4320-gradient-blur-4k-wallapapers-v0-6u0dhbv51tbb1.png?width=7680&format=png&auto=webp&s=dd3e47bbdf3f8726432b5742748bef422fad10a8";
        color = "slate";
        hideVersion = "true";
        showStats = "true";
        statusStyle = "basic"; # dot / basic
        headerStyle = "boxed";

        layout = {
          Bookmarks = {
            style = "row";
            header = false;
            columns = "2";
          };
          Docker = {
            style = "row";
            header = false;
            columns = "3";
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

      /*
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
      */

      services = [
        {
          "Docker" = [
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
            {
              "Authelia" = {
                description = "2FA & SSO";
                server = "opal";
                container = "authelia";
                icon = "sh-authelia";
              };
            }
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
            {
              "File Browser" = {
                description = "Web File Manager";
                server = "opal";
                container = "filebrowser";
                icon = "sh-file-browser";
              };
            }
            {
              "OpenTTD" = {
                description = "Business Simulation Game";
                server = "opal";
                container = "openttd";
                icon = "sh-openttd";
              };
            }
          ];
        }
      ];
    };
  };
}
