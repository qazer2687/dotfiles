{
  lib,
  config,
  pkgs,
  ...
}: {
  options.modules.fonts.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.fonts.enable {
    fonts = {
      #? Enables a set of fonts families and styles
      #? for reasonable coverage of unicode.
      enableDefaultPackages = true;
      #? Additional fonts to install.
      packages = with pkgs; [
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
        agave
        terminus_font
      ];
    };
  };
}
