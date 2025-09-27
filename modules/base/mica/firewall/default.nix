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

      extraCommands = ''
        # Route netbird.qazer.org through default gateway instead of NetBird tunnel
        ip route add netbird.qazer.org via $(ip route | grep default | awk '{print $3}') dev $(ip route | grep default | awk '{print $5}') 2>/dev/null || true
      '';

      allowedTCPPorts = [
        # SSH
        22
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
        443
        3478
        51820
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
