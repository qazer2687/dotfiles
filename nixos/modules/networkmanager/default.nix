{
  lib,
  config,
  ...
}: {
  options.systemModules.networkmanager.enable = lib.mkEnableOption "";
  options.systemModules.networkmanager.firewall.enable = lib.mkEnableOption "";

  config = lib.mkMerge [
    (lib.mkIf config.systemModules.networkmanager.enable {
      networking.networkmanager.enable = true;
      systemd.services.NetworkManager-wait-online.enable = false;
      systemd.network.wait-online.enable = false;
    })
    (lib.mkIf config.systemModules.networkmanager.firewall.enable {
      networking.firewall = {
        enable = true;
        allowedTCPPorts = [22 80 443 25565]; # SSH, HTTP, HTTPS, MC
        allowedUDPPortRanges = [
          {
            from = 4000;
            to = 4007;
          }
          {
            from = 8000;
            to = 8010;
          }
        ];
      };
    })
  ];
}
