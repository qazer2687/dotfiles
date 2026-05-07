{
  lib,
  config,
  pkgs,
  ...
}: {
  options.modules.opentrack.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.opentrack.enable {
    # opentrack for assetto corsa head tracking
    environment = {
      systemPackages = with pkgs; [
        opentrack
        p7zip
        wget
        v4l-utils
        python3
        protontricks
      ];
      sessionVariables.PATH = [ "$HOME/.local/bin" ];
    };
    services.udev.extraRules = ''
      SUBSYSTEM=="video4linux", ATTRS{idVendor}=="1415", ATTRS{idProduct}=="2000", RUN+="${pkgs.v4l-utils}/bin/v4l2-ctl -d $env{DEVNAME} --set-parm=60"
    '';
  };
}
