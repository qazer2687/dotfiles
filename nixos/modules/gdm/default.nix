{
  lib,
  config,
  ...
}: {
  options.systemModules.gdm.xorg.enable = lib.mkEnableOption "";
  options.systemModules.gdm.wayland.enable = lib.mkEnableOption "";
  options.systemModules.gdm.autologin.enable = lib.mkEnableOption "";

  config = lib.mkMerge [
    (lib.mkIf config.systemModules.gdm.xorg.enable {
      services.xserver = {
        enable = true;
        displayManager.gdm.enable = true;
      };
    })
    (lib.mkIf config.systemModules.gdm.wayland.enable {
      services.xserver = {
        enable = true;
        displayManager.gdm.enable = true;
        displayManager.gdm.wayland = true;
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
