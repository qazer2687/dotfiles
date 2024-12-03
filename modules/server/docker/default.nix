{
  lib,
  config,
  ...
}: {
  options.modules.server.docker.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.server.docker.enable {
    virtualisation.docker = {
      enable = true;
      daemon.settings = {
        data-root = "/var/lib/docker";
        "hosts" = [ "tcp://0.0.0.0:2376" "unix:///var/run/docker.sock" ];
      };
    };
    # Starts docker directly after multi-user.target is reached.
    systemd.timers.docker = {
      unitConfig.OnBootSec = "1sec";
      wantedBy = [ "timers.target" ];
    };
  };
}
