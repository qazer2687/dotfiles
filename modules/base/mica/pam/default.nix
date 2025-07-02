{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: {
  options.modules.pam.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.pam.enable {
    environment.systemPackages = [ pkgs.pam_passwdqc ];
    security.pam = {
      loginDefs = {
        SHA_CRYPT_MIN_ROUNDS = 5000;
        SHA_CRYPT_MAX_ROUNDS = 5000;
        PASS_MIN_DAYS = 1;
        PASS_MAX_DAYS = 360;
      };
    };
  };
}
