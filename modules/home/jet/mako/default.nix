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
        background-color = "#232634";
        text-color = "#c6d0f5";
        border-color = "#ca9ee6";
        border-radius = 4;
        border-size = 2;
        progress-color = "source #ca9ee6";
        font = "TX02 11";
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
