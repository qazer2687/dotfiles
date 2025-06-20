{
  lib,
  config,
  pkgs,
  ...
}: {
  options.modules.docker.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.docker.enable {
    users.users.dockremap = {
      isSystemUser = true;
      group = "dockremap";
      subUidRanges = [{ startUid = 165536; count = 65536; }];
      subGidRanges = [{ startGid = 165536; count = 65536; }];
    users.groups.dockremap = {};
    
    users.users.alex.extraGroups = ["docker" "dockremap"];
    
    virtualisation.docker = {
      enable = true;
      daemon.settings = {
        data-root = "/var/lib/docker";
        "hosts" = ["unix:///var/run/docker.sock"];
        
        # A fix for s6-svscan hanging on shutdown.
        # https://github.com/NixOS/nixpkgs/issues/182916#issuecomment-1364504677
        live-restore = false;
        
        # Make all containers be owned by the dockremap user and
        # editable by my user if they are in the dockremap group.
        userns-remap = "default";
        
        # Use crun as the default runtime
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
