{
  lib,
  config,
  ...
}: {
  options.modules.firewall.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.firewall.enable {
    networking.firewall = {
      enable = true; # Ensure the firewall is enabled

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
      ];

      allowedUDPPorts = [
        # DNS
        53
        # qBittorrent
        6881
      ];
    };
  };
}
