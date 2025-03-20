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
      # A fix for s6-svscan hanging on shutdown.
      # https://github.com/NixOS/nixpkgs/issues/182916#issuecomment-1364504677
      liveRestore = false;
      daemon.settings = {
        #features.cdi = true;
        data-root = "/var/lib/docker";
        "hosts" = ["tcp://0.0.0.0:2376" "unix:///var/run/docker.sock"];
      };
    };
  };
}
