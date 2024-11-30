{
  lib,
  config,
  ...
}: let
  domain = "qazer.org";
  # Function to create virtualHosts.
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

  # Cloudflare DNS Configuration
  # A - @ -> 100.100.101.66
  # A - *.qazer.org -> 100.100.101.66

  options.modules.server.nginx.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.server.nginx.enable {
    networking.firewall.allowedTCPPorts = [ 80 ];
    services.nginx = {
      enable = true;
      # Disables checking body size, allowing nextcloud to recieve large files.
      clientMaxBodySize = "0";
      recommendedProxySettings = true;
      recommendedOptimisation = true;
      virtualHosts = lib.mkMerge [
        (mkRP "grafana" "3000")
        (mkRP "pihole" "3001")
        (mkRP "nextcloud" "8080")
        (mkRP "dashboard" "8082")
        (mkRP "prometheus" "9090")
        (mkRP "portainer" "9443")
        (mkRP "node-exporter" "9100")
        (mkRP "cockpit" "10000")
      ];
    };
  };
}
