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
      package = pkgs.aw-server-rust;
      watchers = mkIf hasWayland { awatcher.package = pkgs.awatcher; };
    };

    systemd.user.services.activitywatch-watcher-awatcher = {
      Unit = {
        After = [ "graphical-session.target" ];
        PartOf = [ "graphical-session.target" ];
      };
      Install = { WantedBy = [ "graphical-session.target" ]; };
    };
  };
}
