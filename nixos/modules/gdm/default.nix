{
  lib,
  config,
  ...
}: {
  options.systemModules.gdm.enable = lib.mkEnableOption "";
  options.systemModules.gdm.autologin.enable = lib.mkEnableOption "";

  config = lib.mkMerge [
    (lib.mkIf config.systemModules.gdm.enable {
      services.xserver = {
        enable = true;
      };
    })
    (lib.mkIf config.systemModules.gdm.autologin.enable {
      services.xserver = {
        displayManager.autoLogin.enable = true;
        displayManager.autoLogin.user = "alex";
        displayManager.defaultSession = "none+i3";
      };
    })
  ];
}
