{
  lib,
  config,
  ...
}: {
  options.modules.pam.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.pam.enable {
    security.loginDefs.settings = {
      SHA_CRYPT_MIN_ROUNDS = 10000;
      SHA_CRYPT_MAX_ROUNDS = 10000;
      PASS_MIN_DAYS = 1;
      PASS_MAX_DAYS = 360;
    };
  };
}
