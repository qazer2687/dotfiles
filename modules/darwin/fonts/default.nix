{
  lib,
  config,
  pkgs,
  ...
}: {
  options.modules.fonts.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.fonts.enable {
    fonts.packages = with pkgs; [
      atkinson-hyperlegible
      noto-fonts-color-emoji
      noto-fonts-cjk-sans
      
      nerd-fonts.FiraCode
      nerd-fonts.FiraMono
      nerd-fonts.Iosevka
      nerd-fonts.LiberationMono
    ];
  };
}
