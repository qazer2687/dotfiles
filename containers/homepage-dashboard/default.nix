{
  lib,
  config,
  pkgs,
  ...
}: {
  options.container.homepage-dashboard.enable = lib.mkEnableOption "";

  config = lib.mkIf config.container.homepage-dashboard.enable {

    virtualisation.oci-containers.containers.homepage = {
      image = "ghcr.io/benphelps/homepage:latest";
      autoStart = true;
      ports = [ "80:3000" ];
      volumes = [
        "/home/alex/.config/homepage-dashboard:/app/config"
        "/run/podman/podman.sock:/var/run/docker.sock"
      ];
    };
  };
}