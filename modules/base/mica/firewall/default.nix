{
  lib,
  config,
  ...
}: {
  options.modules.firewall.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.firewall.enable {
    networking.firewall = {
      enable = true;

      #trustedInterfaces = ["tailscale0" "docker0"];

      allowedTCPPorts = [
        # HTTP
        80
        81
        # HTTPS
        443
        # DNS
        53
        # qBittorrent
        6881
        # Netbird
        33073
        10000
      ];

      allowedUDPPorts = [
        # DNS
        53
        # qBittorrent
        6881
        # Netbird
        3478
      ];

      allowedUDPPortRanges = [
        {
          # Netbird
          from = 49152;
          to = 65535;
        }
      ];
    };
  };
}
