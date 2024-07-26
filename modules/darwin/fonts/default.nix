{
  lib,
  config,
  self,
  ...
}: {
  options.modules.fonts.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.fonts.enable {
    fonts.packages = with self.packages; [
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
