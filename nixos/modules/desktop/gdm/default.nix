{
  lib,
  config,
  ...
}: {
  options.systemModules.desktop.gdm.enable = lib.mkEnableOption "";
  options.systemModules.desktop.gdm.autologin.enable = lib.mkEnableOption "";

  config = lib.mkMerge [
    (lib.mkIf config.systemModules.desktop.gdm.enable {
      services.xserver = {
        enable = true;
        displayManager.gdm.enable = true;
      };
    })
    (lib.mkIf config.systemModules.desktop.gdm.autologin.enable {
      services.xserver = {
        displayManager.autoLogin.enable = true;
        displayManager.autoLogin.user = "alex";
        displayManager.defaultSession = "none+i3";
      };
    })
  ];
}
