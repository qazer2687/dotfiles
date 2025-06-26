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
        border-radius = 6;
        border-size = 2;
        progress-color = "source #ff0000";
        font = "Departure Mono 14";
        width = 600;
        height = 240;
        margin = "4";
        padding = "10";
        default-timeout = 5000;
        layer = "top";
        anchor = "top-right";
      };
    };
  };
}
