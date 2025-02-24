{
  lib,
  config,
  ...
}: {
  options.modules.server.docker.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.server.docker.enable {

    hardware.nvidia-container-toolkit.enable = true;
    virtualisation.docker = {
      enable = true;
      daemon.settings = {
        features.cdi = true;
        data-root = "/var/lib/docker";
        "hosts" = ["tcp://0.0.0.0:2376" "unix:///var/run/docker.sock"];
      };
    };
  };
}
