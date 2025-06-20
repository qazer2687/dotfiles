{
  lib,
  config,
  pkgs,
  ...
}: {
  options.modules.docker.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.docker.enable {

    users = {
      groups.alex.gid = 1000;
      users.alex = {
        uid = 1000;
        group = "alex";
        extraGroups = ["docker"];
      };
    };
     
    # This option gives docker containers running
    # as 1000:1000 permission to bind to any port
    # starting from port 80. This is specifically
    # required so that I can use caddy without
    # running the container as root.
    boot.kernel.sysctl = {
      "net.ipv4.ip_unprivileged_port_start" = 80;
    };
    
    virtualisation.docker = {
      enable = true;
      daemon.settings = {
        data-root = "/var/lib/docker";
        "hosts" = ["unix:///var/run/docker.sock"];
        
        # A fix for s6-svscan hanging on shutdown.
        # https://github.com/NixOS/nixpkgs/issues/182916#issuecomment-1364504677
        live-restore = false;
        
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
