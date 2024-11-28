{
  lib,
  config,
  ...
}: {
  options.modules.server.nginx.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.server.nginx.enable {
    services.nginx = {
      enable = true;
      recommendedZstdSettings = true;
      recommendedTlsSettings = true;
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
