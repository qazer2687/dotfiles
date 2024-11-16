{
  lib,
  config,
  inputs,
  ...
}: {
  options.modules.server.caddy.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.server.caddy.enable {
    services.caddy = {
      enable = true;
      extraConfig = ''
        tls {
          dns cloudflare {
            api_token "${sops.secrets."cloudflare-api-key"}"
        }
      '';
      virtualHosts."grafana.qazer.org".extraConfig = ''
        reverse_proxy http://opal:3000
        import cloudflare
      '';
      virtualHosts."pihole.example.org".extraConfig = ''
        reverse_proxy http://opal:3001
        import cloudflare
      '';
      virtualHosts."prometheus.qazer.org".extraConfig = ''
        reverse_proxy http://opal:9090
        import cloudflare
      '';
      virtualHosts."node-exporter.qazer.org".extraConfig = ''
        reverse_proxy http://opal:9100
        import cloudflare
      '';
      virtualHosts."cockpit.qazer.org".extraConfig = ''
        reverse_proxy http://opal:10000
        import cloudflare
      '';
      virtualHosts."minecraft.qazer.org".extraConfig = ''
        reverse_proxy http://opal:25565
        import cloudflare
      '';
    };
  };
}
