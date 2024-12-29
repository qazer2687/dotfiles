{
  lib,
  config,
  pkgs,
  ...
}: {
  options.modules.rustdesk.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.rustdesk.enable {
    services.rustdesk-server = {
      enable = true;
    };
  };
}
