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
        background-color = "#1e1e2e";
        text-color = "#cdd6f4";
        border-color = "#cba6f7";
        border-radius = 6;
        border-size = 2;
        progress-color = "source #cba6f7";
        font = "Iosevka Nerd Font 12";
        width = 600;
        height = 400;
        margin = "4";
        padding = "4";
        default-timeout = 10000;
        layer = "bottom";
        anchor = "bottom-right";
      };
    };
  };
}
