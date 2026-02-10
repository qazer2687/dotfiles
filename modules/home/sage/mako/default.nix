{
  lib,
  config,
  pkgs,
  base16,
  ...
}: let
  scheme = base16 "black-metal";
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
        border-size = 2;
        progress-color = "source #${scheme.base05}";
        font = "PragmataPro 22";
        width = 600;
        height = 400;
        margin = "16";
        padding = "8";
        default-timeout = 10000;
        layer = "top";
        anchor = "top-right";
      };
    };
  };
}
