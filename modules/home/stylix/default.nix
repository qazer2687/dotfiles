{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: {
  options.modules.stylix.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.stylix.enable {
    stylix = {
      enable = true;
      autoEnable = false;
      image = /home/alex/.config/wallpaper/wallpaper.png;
      polarity = "dark";

      fonts = {
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
          noto-fonts-cjk-sans
          terminus_font
        ];
      };

      cursor = {
        name = "Bibata-Modern-Ice";
        package = pkgs.bibata-cursors;
        size = 24;
      };
    };
  };
}
