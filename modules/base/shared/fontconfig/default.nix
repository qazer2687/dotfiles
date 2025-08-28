{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: {
  options.modules.fontconfig.enable = lib.mkEnableOption "";
  
  config = lib.mkIf config.modules.fontconfig.enable {
    fonts.fontconfig = {
      enable = true;
      antialias = true;
      subpixel = {
        rgba = "rgb";
        lcdfilter = "default";
      };
      hinting = {
        enable = true;
        style = "slight";
      };
    };
  };
}
