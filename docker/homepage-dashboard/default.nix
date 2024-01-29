{
  lib,
  config,
  pkgs,
  ...
}: {
  options.docker.homepage-dashboard.enable = lib.mkEnableOption "";

  config = lib.mkIf config.docker.homepage-dashboard.enable {

    virtualisation.oci-containers.containers.homepage = {
      image = "ghcr.io/gethomepage/homepage:latest";
      autoStart = true;
      ports = [ "80:3000" ];
      volumes = [
        "/home/alex/.config/homepage-dashboard:/app/config"
        "/run/podman/podman.sock:/var/run/docker.sock"
      ];
    };
  };
}