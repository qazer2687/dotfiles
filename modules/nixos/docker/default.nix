{
  lib,
  config,
  ...
}: {
  options.modules.docker.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.docker.enable {
    
    users.users.alex.extraGroups = ["docker"];

    virtualisation.docker = {
      enable = true;
      daemon.settings = {
        #features.cdi = true;
        data-root = "/var/lib/docker";
        "hosts" = ["tcp://0.0.0.0:2376" "unix:///var/run/docker.sock"];
      };
    };
  };
}
