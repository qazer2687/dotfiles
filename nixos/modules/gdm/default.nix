{
  lib,
  config,
  ...
}: {
  options.systemModules.gdm.jade.enable = lib.mkEnableOption "";
  options.systemModules.gdm.ruby.enable = lib.mkEnableOption "";
  options.systemModules.gdm.autologin.enable = lib.mkEnableOption "";

  config = lib.mkMerge [
    (lib.mkIf config.systemModules.gdm.jade.enable {
      services.xserver = {
        enable = true;
        displayManager.gdm.enable = true;
      };
    })
    (lib.mkIf config.systemModules.gdm.ruby.enable {
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
