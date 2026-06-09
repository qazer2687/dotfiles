{
  lib,
  config,
  ...
}: {
  options.modules.fontconfig.enable = lib.mkEnableOption "";
  config = lib.mkIf config.modules.fontconfig.enable {
    fonts.fontconfig = {
      enable = true;
      antialias = true;
      subpixel = {
        rgba = "none";
        lcdfilter = "none";
      };
      hinting = {
        enable = true;
        style = "slight";
      };
    };
  };
}
