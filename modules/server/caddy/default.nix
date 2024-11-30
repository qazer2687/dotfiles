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
      '';
      virtualHosts."grafana.qazer.org".extraConfig = ''
        reverse_proxy http://100.100.101.66:3000
      '';
      virtualHosts."pihole.qazer.org".extraConfig = ''
        reverse_proxy http://100.100.101.66:3001
      '';
      virtualHosts."dashboard.qazer.org".extraConfig = ''
        reverse_proxy http://100.100.101.66:8082
      '';
      virtualHosts."prometheus.qazer.org".extraConfig = ''
        reverse_proxy http://100.100.101.66:9090
      '';
      virtualHosts."portainer.qazer.org".extraConfig = ''
        reverse_proxy http://100.100.101.66:9443
      '';
      virtualHosts."node-exporter.qazer.org".extraConfig = ''
        reverse_proxy http://100.100.101.66:9100
      '';
      virtualHosts."cockpit.qazer.org".extraConfig = ''
        reverse_proxy http://100.100.101.66:10000
      '';
      virtualHosts."nextcloud.qazer.org".extraConfig = ''
        reverse_proxy http://100.100.101.66:11000
      '';
    };
  };
}
