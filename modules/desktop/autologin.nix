{ inputs, lib, config, pkgs, ... }:
{
  options.modules.desktop.autologin.enable = lib.mkEnableOption "";
  config = lib.mkIf config.modules.desktop.autologin.enable {
    services.xserver = {
      enable = true;
      displayManager.lightdm.enable = true;
      displayManager.autoLogin.enable = true;
      displayManager.autoLogin.user = "alex";
      displayManager.defaultSession = "none+i3";
    };
  };
}