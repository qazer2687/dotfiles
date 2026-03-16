{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: {
  options.modules.activitywatch.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.activitywatch.enable {
    services.activitywatch = {
      enable = true;
      package = pkgs.aw-server-rust;
    };
  };
}
