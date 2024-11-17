{
  lib,
  config,
  inputs,
  ...
}: {
  options.modules.server.caddy.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.server.caddy.enable {
    sops.secrets.cloudflare-api-token = {};
    services.caddy = {
      enable = true;
      extraConfig = ''
        tls {
          dns cloudflare {
            api_token "$(cat ${config.sops.secrets.cloudflare-api-token.path})"
        }
      '';
      virtualHosts."grafana.qazer.org".extraConfig = ''
        reverse_proxy http://100.100.101.66:3000
        import cloudflare
      '';
      virtualHosts."pihole.example.org".extraConfig = ''
        reverse_proxy http://100.100.101.66:3001
        import cloudflare
      '';
      virtualHosts."prometheus.qazer.org".extraConfig = ''
        reverse_proxy http://100.100.101.66:9090
        import cloudflare
      '';
      virtualHosts."node-exporter.qazer.org".extraConfig = ''
        reverse_proxy http://100.100.101.66:9100
        import cloudflare
      '';
      virtualHosts."cockpit.qazer.org".extraConfig = ''
        reverse_proxy http://100.100.101.66:10000
        import cloudflare
      '';
      virtualHosts."minecraft.qazer.org".extraConfig = ''
        reverse_proxy http://100.100.101.66:25565
        import cloudflare
      '';
    };
  };
}


