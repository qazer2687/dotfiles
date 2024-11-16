{
  lib,
  config,
  ...
}: {
  options.modules.server.caddy.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.server.caddy.enable {
    services.caddy = {
      enable = true;
      globalConfig = ''
        admin 0.0.0.0:2021
      '';
      virtualHosts."grafana.qazer.org".extraConfig = ''
        reverse_proxy http://opal:3000
      '';
      virtualHosts."pihole.example.org".extraConfig = ''
        reverse_proxy http://opal:3001
      '';
      virtualHosts."prometheus.qazer.org".extraConfig = ''
        reverse_proxy http://opal:9090
      '';
      virtualHosts."node-exporter.qazer.org".extraConfig = ''
        reverse_proxy http://opal:9100
      '';
      virtualHosts."cockpit.qazer.org".extraConfig = ''
        reverse_proxy http://opal:10000
      '';
      virtualHosts."minecraft.qazer.org".extraConfig = ''
        reverse_proxy http://opal:25565
      '';
    };
  };
}
