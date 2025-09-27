{
  lib,
  config,
  ...
}: {
  options.modules.tailscale.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.tailscale.enable {
    services.tailscale.enable = true;
  };
}
