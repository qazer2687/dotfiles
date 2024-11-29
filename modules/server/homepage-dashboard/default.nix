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
              };
            }
          ];
        }
      ];
    };
  };
}
