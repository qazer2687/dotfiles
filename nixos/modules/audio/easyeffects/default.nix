{
  lib,
  config,
  pkgs,
  ...
}: {
  options.systemModules.audio.easyeffects.enable = lib.mkEnableOption "";

  config = lib.mkIf config.systemModules.audio.easyeffects.enable {

    # Installation
    environment.systemPackages = with pkgs; [ 
      easyeffects
      calf
      libebur128
      zam-plugins
      zita-convolver
      rnnoise
      speexdsp
    ];
  };
}
