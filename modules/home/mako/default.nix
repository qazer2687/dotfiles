{
  lib,
  config,
  ...
}: {
  options.modules.mako.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.mako.enable {
    services.mako = {
      enable = true;
      backgroundColor = "#000000";
      textColor = "#ffffff";
      borderColor = "#ffffff";
      borderRadius = 6;
      borderSize = 1;
      progressColor = "source #ff0000";
      font = "Departure Mono 12";
      width = 300;
      height = 80;
      margin = "10";
      padding = "8";
      defaultTimeout = 5000;
      layer = "top";
      anchor = "top-right";
    };
  };
}
