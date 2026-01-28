{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: {
  options.modules.easyeffects.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.easyeffects.enable {
    environment.systemPackages = with pkgs; [
        easyeffects

        # Plugins
        calf
        libebur128
        zam-plugins
        zita-convolver
        rnnoise
        speexdsp
        libbs2b
    ];
  };
}
