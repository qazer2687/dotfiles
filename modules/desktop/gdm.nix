{ inputs, lib, config, pkgs, ... }: {
  options.modules.desktop.gdm.enable = lib.mkEnableOption "";
  options.modules.desktop.gdm.autologin.enable = lib.mkEnableOption "";

  config = lib.mkMerge [
    (lib.mkIf config.modules.desktop.gdm.enable {
      services.xserver = {
        enable = true;
        displayManager.gdm.enable = true;
      };
    })
    (lib.mkIf config.modules.desktop.gdm.autologin.enable {
      services.xserver = {
        displayManager.autoLogin.enable = true;
        displayManager.autoLogin.user = "alex";
        displayManager.defaultSession = "none+i3";
      };
    })
  ];
}
