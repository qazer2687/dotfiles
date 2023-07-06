{ inputs, lib, config, pkgs, ... }:
{
  options.modules.network.firewall.enable = lib.mkEnableOption "";
  config = lib.mkIf config.modules.network.firewall.enable {
    networking.firewall = {
      enable = true;
      allowedTCPPorts = [ 22 80 443 25565 ]; # SSH, HTTP, HTTPS, MC
      allowedUDPPortRanges = [
        { from = 4000; to = 4007; }
        { from = 8000; to = 8010; }
      ];
    };
  };
}
