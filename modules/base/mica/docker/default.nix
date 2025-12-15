{
  lib,
  config,
  pkgs,
  ...
}: {
  options.modules.docker.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.docker.enable {

    users.users.alex = {
      extraGroups = ["docker"];
    };
    
    users.groups.dockremap.gid = 10000;
    users.users.dockremap = {
      isSystemUser = true;
      uid = 10000;
      group = "dockremap";
      subUidRanges = [
        { startUid = 1000; count = 1; }
        { startUid = 100001; count = 65535; }
      ];
      subGidRanges = [
        { startGid = 1000; count = 1; }
        { startGid = 100001; count = 65535; }
      ];
    };

    virtualisation.docker = {
      enable = true;
      daemon.settings = {
        data-root = "/var/lib/docker";
        "hosts" = ["unix:///var/run/docker.sock"];
        # Fix for some services just not being able to communicate
        # with the web, for completely unknown reasons.
        dns = ["1.1.1.1"];
        
        # Enable user namespace remapping so containers run as root
        # but are seen by the host as a non-privileged user.
        userns-remap = "default";

        # A fix for s6-svscan hanging on shutdown.
        # https://github.com/NixOS/nixpkgs/issues/182916#issuecomment-1364504677
        live-restore = false;

        # Use crun as the default runtime.
        "default-runtime" = "crun";
        "runtimes" = {
          "crun" = {
            "path" = "${pkgs.crun}/bin/crun";
          };
        };
      };
    };
  };
}
