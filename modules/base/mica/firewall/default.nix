{
  lib,
  config,
  ...
}: {
  options.modules.firewall.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.firewall.enable {
    networking = {
      bridges = {
        public = {};
        private = {};
      };

      interfaces = {
        public = {
          ipv4.addresses = [ { address = "10.0.10.1"; prefixLength = 24; } ];
        };
        private = {
          ipv4.addresses = [ { address = "10.0.20.1"; prefixLength = 24; } ];
        };
      };
    
    
      firewall = {
        enable = true;

        #trustedInterfaces = ["tailscale0" "docker0"];

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
  };
}
