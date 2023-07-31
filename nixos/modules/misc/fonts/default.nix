{
  lib,
  config,
  pkgs,
  ...
}: {
  options.systemModules.misc.fonts.enable = lib.mkEnableOption "";

  config = lib.mkIf config.systemModules.misc.fonts.enable {
    fonts.packages = with pkgs; [
      (nerdfonts.override {
        fonts = [
          "FiraCode"
        ];
      })
    ];
  };
}