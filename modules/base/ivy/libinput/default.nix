{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: {
  options.modules.libinput.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.libinput.enable {
    services.libinput = {
      enable = true;
      touchpad = {
        tapping = true;
        naturalScrolling = true;
        scrollMethod = "twofinger";
        disableWhileTyping = true;
        accelProfile = "flat";
        accelSpeed = "0.5";
      };
    };
  };
}
