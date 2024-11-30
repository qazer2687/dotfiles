{
  lib,
  config,
  inputs,
  ...
}: let

  cloudflare-api-token = builtins.readFile config.sops.secrets.cloudflare-api-token.path;
  cloudflare-email = builtins.readFile config.sops.secrets.cloudflare-email.path;

  # Function to create virtualHosts for Caddy
  mkRP = sub: port: let
    dom = if sub == "" then "qazer.org" else "${sub}.qazer.org";
  in {
    "${dom}" = {
      extraConfig = ''
        reverse_proxy http://100.100.101.66:${port}
        import cloudflare
      '';
    };
  };

in {

  options.modules.server.caddy.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.server.caddy.enable {
    sops.secrets.cloudflare-api-token = {};
    services.caddy = {
      enable = true;
      extraConfig = ''
        tls {
          dns cloudflare {
            api_token "${cloudflare-api-token}"
          }
        }
      '';
      virtualHosts = lib.mkMerge [
        (mkRP "grafana" "3000")
        (mkRP "pihole" "3001")
        (mkRP "dashboard" "8082")
        (mkRP "prometheus" "9090")
        (mkRP "portainer" "9443")
        (mkRP "node-exporter" "9100")
        (mkRP "cockpit" "10000")
        (mkRP "nextcloud" "11000")
      ];
    };
  };
}
