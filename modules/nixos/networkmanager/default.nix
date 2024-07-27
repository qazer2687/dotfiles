{
  lib,
  config,
  pkgs,
  ...
}: {
  options.modules.networkmanager.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.networkmanager.enable {
    networking = {
      networkmanager.enable = true;
      firewall.enable = true;
      nameservers = ["172.18.0.2" "1.1.1.1"]; # use pihole
    };
    systemd = {
      services.NetworkManager-wait-online.enable = false;
      network.wait-online.enable = false;
    };
  };
}
