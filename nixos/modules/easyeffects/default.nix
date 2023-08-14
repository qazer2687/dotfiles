{
  lib,
  config,
  pkgs,
  ...
}: {
  options.systemModules.easyeffects.enable = lib.mkEnableOption "";

  config = lib.mkIf config.systemModules.easyeffects.enable {

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
