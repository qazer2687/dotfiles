{
  lib,
  config,
  pkgs,
  ...
}: {
  options.modules.mako.enable = lib.mkEnableOption "";
  config = lib.mkIf config.modules.mako.enable {
    home.packages = [pkgs.libnotify];
    services.mako = {
      enable = true;
      settings = {
        background-color = "#000000";
        text-color = "#ffffff";
        border-color = "#ffffff";
        border-radius = 2;
        border-size = 1;
        progress-color = "source #ff0000";
        font = "Departure Mono 8";
        width = 500;
        height = 120;
        margin = "4";
        padding = "10";
        default-timeout = 5000;
        layer = "top";
        anchor = "top-right";
      };
    };
  };
}