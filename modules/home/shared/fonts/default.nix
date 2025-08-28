{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: {
  options.modules.fonts.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.fonts.enable {
    home.packages = with pkgs; [
      noto-fonts-color-emoji
      noto-fonts-cjk-sans

      atkinson-hyperlegible
      agave
      terminus_font
      departure-mono
      eb-garamond
      fixedsys-excelsior
      monaspace
      pragmatapro

      nerd-fonts.fira-code
      nerd-fonts.fira-mono
      nerd-fonts.iosevka
      nerd-fonts.liberation
      nerd-fonts.jetbrains-mono
    ];
  };
}
