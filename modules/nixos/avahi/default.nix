{
  lib,
  config,
  ...
}: {
  options.modules.avahi.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.avahi.enable {
    services.avahi = {
      enable = true;
      nssmdns = true; # printing
      publish = {
        enable = true;
        addresses = true;
        workstation = true;
        userServices = true;
      };
    };
  };
}
