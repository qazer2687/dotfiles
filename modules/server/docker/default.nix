{
  lib,
  config,
  ...
}: {
  options.modules.docker.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.docker.enable {
    virtualisation.docker = {
      enable = true;
      
    };

    users.users.alex.extraGroups = [ "docker" ];
  };
}
