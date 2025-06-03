{
  lib,
  config,
  pkgs,
  ...
}: {
  options.modules.docker.enable = lib.mkEnableOption "";
  
  config = lib.mkIf config.modules.docker.enable {
    environment.systemPackages = with pkgs; [
      crun
    ];
    users.users.alex.extraGroups = ["docker"];
    virtualisation.docker = {
      enable = true;
      # A fix for s6-svscan hanging on shutdown.
      # https://github.com/NixOS/nixpkgs/issues/182916#issuecomment-1364504677
      liveRestore = false;
      daemon.settings = {
        data-root = "/var/lib/docker";
        "hosts" = ["unix:///var/run/docker.sock"];
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