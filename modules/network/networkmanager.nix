{ inputs, lib, config, pkgs, ... }: {
  options.modules.network.networkmanager.enable = lib.mkEnableOption "";
  options.modules.network.networkmanager.firewall.enable = lib.mkEnableOption "";

  config = lib.mkMerge [
    (lib.mkIf config.modules.network.networkmanager.enable {
      networking.networkmanager.enable = true;
      systemd.services.NetworkManager-wait-online.enable = false;
      systemd.network.wait-online.enable = false;
    })
    (lib.mkIf config.modules.network.networkmanager.firewall.enable {
      networking.firewall = {
        enable = true;
        allowedTCPPorts = [ 22 80 443 25565 ]; # SSH, HTTP, HTTPS, MC
        allowedUDPPortRanges = [
          { from = 4000; to = 4007; }
          { from = 8000; to = 8010; }
        ];
      }; 
    })
  ];
}
