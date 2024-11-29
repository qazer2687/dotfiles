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
        color = "slate";
        hideVersion = "true";

      };
      widgets = [
        {
          greeting = {
            text = "Hey!";
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
          "Docker" = [
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
                href = "http://portainer.qazer.org/";
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
