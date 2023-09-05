{
  lib,
  config,
  pkgs,
  ...
}: {
  options.systemModules.fonts.enable = lib.mkEnableOption "";

  config = lib.mkIf config.systemModules.fonts.enable {
    fonts.packages = with pkgs; [
      (nerdfonts.override {
        fonts = [
          "FiraCode"
          "FiraMono"
          "Iosevka"
        ];
      })
    ];
  };
}
