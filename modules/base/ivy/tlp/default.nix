{
  lib,
  config,
  pkgs,
  ...
}: {
  options.modules.tlp.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.tlp.enable {
    services.tlp = {
      enable = true;
      settings = {
      
      };
    };
  };
}
