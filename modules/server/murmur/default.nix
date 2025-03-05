{
  lib,
  config,
  ...
}: {
  options.modules.server.murmur.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.server.murmur.enable {
    services.murmur = {
      enable = true;
      # Routing through tailnet.
      openFirewall = false;
    };
  };
}
