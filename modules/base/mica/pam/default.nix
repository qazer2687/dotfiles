{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: {
  options.modules.pam.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.pam.enable {
    security.pam = {
      
    };
  };
}
