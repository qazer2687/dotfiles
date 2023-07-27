{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  options.systemModules.misc.fonts.enable = lib.mkEnableOption "";

  config = lib.mkIf config.systemModules.misc.fonts.enable {
    fonts.fonts = with pkgs; [
      (nerdfonts.override {
        fonts = [
          "FiraCode"
        ];
      })
    ];
  };
}
