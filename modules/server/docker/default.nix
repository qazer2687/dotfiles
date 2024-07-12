{
  lib,
  config,
  ...
}: {
  options.modules.docker.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.docker.enable {
    virtualisation.docker = {
      enable = true;
      rootless = {
        enable = true;
        setSocketVariable = true;
      };
      daemon.settings = {
        data-root = "/home/alex/.docker";
      };
    };
  };
}
