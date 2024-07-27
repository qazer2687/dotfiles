{
  lib,
  config,
  pkgs,
  ...
}: {
  options.modules.security.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.security.enable {
    security.pam.enableSudoTouchIdAuth = true;
  };
}
