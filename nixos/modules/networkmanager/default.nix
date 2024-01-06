{
  lib,
  config,
  ...
}: {
  options.systemModules.networkmanager.enable = lib.mkEnableOption "";

  config = lib.mkIf config.systemModules.networkmanager.enable {
    networking = {
      networkmanager.enable = true;
      firewall = {
        enable = true;
        allowedTCPPorts = [22 80 443 25565];
      };
    };
    systemd = {
      services.NetworkManager-wait-online.enable = false;
      network.wait-online.enable = false;
    };
  };
}
