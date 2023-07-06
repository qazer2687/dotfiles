{ inputs, lib, config, pkgs, ... }:
{
  options.modules.network.networkmanager.enable = lib.mkEnableOption "";
  config = lib.mkIf config.modules.network.networkmanager.enable {
    networking.networkmanager.enable = true;
    systemd.services.NetworkManager-wait-online.enable = false;
    systemd.network.wait-online.enable = false;
  };
}
