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
        background-color = "#181926";
        text-color = "#cad3f5";
        border-color = "#c6a0f6";
        border-radius = 4;
        border-size = 1;
        progress-color = "source #c6a0f6";
        font = "Departure Mono 11";
        width = 600;
        height = 400;
        margin = "8";
        padding = "4";
        default-timeout = 10000;
        layer = "bottom";
        anchor = "bottom-right";
      };
    };
  };
}
