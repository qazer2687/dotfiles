{
  lib,
  config,
  ...
}: {
  options.modules.fonts.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.fonts.enable {
    fonts.packages = with pkgs; [
      (nerdfonts.override {
        fonts = [
          "FiraCode"
          "FiraMono"
          "Iosevka"
          "LiberationMono"
        ];
      })
      atkinson-hyperlegible
      noto-fonts-color-emoji
      noto-fonts-cjk-sans
    ];
  };
}
