{
  lib,
  config,
  pkgs,
  ...
}: {
  options.modules.mako.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.mako.enable {
    home.packages = [ pkgs.libnotify ];
    services.mako = {
      enable = true;
      backgroundColor = "#000000";
      textColor = "#ffffff";
      borderColor = "#ffffff";
      borderRadius = 2;
      borderSize = 1;
      progressColor = "source #ff0000";
      font = "Departure Mono 8";
      width = 300;
      height = 80;
      margin = "10";
      padding = "2";
      defaultTimeout = 5000;
      layer = "top";
      anchor = "top-right";
    };
  };
}
