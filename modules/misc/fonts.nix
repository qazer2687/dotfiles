{ inputs, lib, config, pkgs, ... }:
{
  options.modules.misc.fonts.enable = lib.mkEnableOption "";
  config = lib.mkIf config.modules.misc.fonts.enable {
    fonts.fonts = with pkgs; [( nerdfonts.override {
      fonts = [
        "FiraCode" 
      ];
    })];
  };
}