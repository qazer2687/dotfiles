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
      backgroundColor = "#222222";
      textColor = "#dddddd";
      borderColor = "#dddddd";
      borderRadius = 2;
      borderSize = 1;
      progressColor = "source #ffaaaa";
      font = "Departure Mono 8";
      width = 300;
      height = 80;
      margin = "10";
      padding = "4";
      defaultTimeout = 5000;
      layer = "top";
      anchor = "top-right";
    };
  };
}
