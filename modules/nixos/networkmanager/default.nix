{
  lib,
  config,
  ...
}: {
  options.modules.networkmanager.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.networkmanager.enable {
    networking = {
      networkmanager.enable = true;
      firewall.enable = true;
    };
    systemd = {
      services.NetworkManager-wait-online.enable = false;
      network.wait-online.enable = false;
    };
  };
}
