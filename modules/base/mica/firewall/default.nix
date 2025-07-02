{
  lib,
  config,
  ...
}: {
  options.modules.firewall.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.firewall.enable {
    networking.firewall = {
      enable = true; # Ensure the firewall is enabled

      # Trusted Interfaces (e.g., for Tailscale, allowing its traffic)
      trustedInterfaces = ["tailscale0"];

      # Allowed Incoming TCP Ports
      # Combining all previously requested TCP ports
      allowedTCPPorts = [
        # HTTP
        80
        # HTTPS
        443
        # DNS
        53
        # qBittorrent
        6881
      ];

      # Allowed Incoming UDP Ports
      # Combining all previously requested UDP ports
      allowedUDPPorts = [
        # DNS
        53
        # qBittorrent
        6881
      ];
    };
  };
}
