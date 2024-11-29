{
  lib,
  config,
  ...
}: let
  domain = "qazer.org";
  mkRP =
    sub: port:
    let
      dom = if sub == "" then domain else "${sub}.${domain}";
    in {
      "${dom}" = {
        locations."/" = {
          proxyPass = "http://127.0.0.1:${port}/";
        };
      };
    };
in {

  options.modules.server.nginx.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.server.nginx.enable {
    networking.firewall.allowedTCPPorts = [ 80 ];
    services.nginx = {
      enable = true;
      config = ''
        http {
          server {
            listen 0.0.0.0:80;
            listen [::]:80;
            server_name localhost;
          }
        }
      '';
      recommendedProxySettings = true;
      recommendedOptimisation = true;
      virtualHosts = lib.mkMerge [
        (mkRP "grafana" "3000")
        (mkRP "pihole" "3001")
        (mkRP "portainer" "8000")
        (mkRP "prometheus" "9090")
        (mkRP "node-exporter" "9100")
        (mkRP "cockpit" (builtins.toString config.services.cockpit.port))
        (mkRP "dashboard" (builtins.toString config.services.homepage-dashboard.listenPort))
      ];
    };
  };
}
