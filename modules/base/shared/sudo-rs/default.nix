{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: {
  options.modules.sudo-rs.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.sudo-rs.enable {
    security.sudo.enable = false;
    security.sudo-rs = {
      enable = true;
      wheelNeedsPassword = true;
    };
  };
}
