{
  lib,
  config,
  ...
}: {
  options.modules.chrony.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.chrony.enable {
    services.chrony = {
      enable = true;

      # Enable Network Time Security (NTS) for enhanced security.
      enableNTS = true;
      servers = [
        "time.cloudflare.com iburst nts"
      ];
    };

    # Allow outgoing UDP port 123 (NTP) and outgoing TCP port 4460 (NTS Key Establishment).
    # Remember to open these on the router.
    networking.firewall.allowedUDPPorts = [123];
    networking.firewall.allowedTCPPorts = [4460];
  };
}
