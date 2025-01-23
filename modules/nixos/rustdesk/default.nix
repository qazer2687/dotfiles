{
  lib,
  config,
  ...
}: {
  options.modules.rustdesk.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.rustdesk.enable {
    services.rustdesk-server = {
      enable = true;
      openFirewall = true;
      relay.enable = true;
      signal = {
        enable = true;
        relayHosts = ["100.69.81.103"];
      };
    };
  };
}
