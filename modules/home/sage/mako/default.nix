{
  lib,
  config,
  pkgs,
  base16,
  ...
}: let
  scheme = base16 "catppuccin-mocha";
in {
  options.modules.mako.enable = lib.mkEnableOption "";
  config = lib.mkIf config.modules.mako.enable {
    home.packages = [pkgs.libnotify];
    services.mako = {
      enable = true;
      settings = {
        background-color = "#${scheme.base00}";
        text-color = "#${scheme.base05}";
        border-color = "#${scheme.base05}";
        border-radius = 0;
        border-size = 1;
        progress-color = "source #${scheme.base05}";
        font = "DepartureMono 11";
        width = 500;
        height = 300;
        margin = "8";
        padding = "4";
        default-timeout = 10000;
        layer = "top";
        anchor = "top-right";
      };
    };
  };
}
