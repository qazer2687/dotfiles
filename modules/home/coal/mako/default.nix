{
  lib,
  config,
  ...
}: {
  options.modules.mako.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.mako.enable {
    services.mako = {
      enable = true;
      settings = {
        font = "Terminus Bold 14";
        format = "%s\\n%b";
        sort = "-time";
        layer = "top";
        anchor = "top-right";
        background-color = "#000000";
        width = 300;
        height = 110;
        margin = 2;
        padding = "0,5,10";
        border-size = 1;
        border-color = "#aaaaaa";
        border-radius = 0;
        icons = false;
        default-timeout = 5000;
        ignore-timeout = true;

        "urgency=critical" = {
          border-color = "#ff0000";
        };
      };
    };
  };
}
