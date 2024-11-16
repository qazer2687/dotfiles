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
        data-root = "/home/alex/.docker"; # sudo chown -R alex ~/.docker
        extraOptions = [
          "--host=tcp://0.0.0.0:2376"
        ];
      };
    };
    users.users.alex.extraGroups = ["docker"];
  };
}
