{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: {
  options.modules.activitywatch.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.activitywatch.enable {
    home.packages = [ pkgs.aw-qt ];
    services.activitywatch = {
      enable = true;
      package = pkgs.activitywatch;
      watchers = {
        aw-watcher-afk = {
          package = pkgs.activitywatch;
          settings = {
            timeout = 180;
            poll_time = 2;
          };
        };
        aw-watcher-window = {
          package = pkgs.activitywatch;
          settings = {
            exclude_title = false;
            poll_time = 1;
          };
        };
      };
      settings = {
        timeout = 180;
      };
    };
  };
}
