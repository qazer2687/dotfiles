{
  lib,
  config,
  ...
}: {
  options.modules.server.docker.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.server.docker.enable {
    virtualisation.docker = {
      enable = true;
      liveRestore = false;
      # Adds 20s to multi-user.target but it doesn't really matter.
      enableOnBoot = true;
      daemon.settings = {
        data-root = "/var/lib/docker";
        "hosts" = [ "tcp://0.0.0.0:2376" "unix:///var/run/docker.sock" ];
      };
    };
  };
}
