{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: {
  options.modules.networkmanager.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.networkmanager.enable {
    networking = {
      wireless.iwd.enable = true;
      networkmanager.wifi.backend = "iwd";
    };
  };
}
