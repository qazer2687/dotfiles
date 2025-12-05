{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: {
  options.modules.k3s.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.k3s.enable {
    networking.firewall.allowedTCPPorts = [
      6443 # k3s: required so that pods can reach the API server (running on port 6443 by default)
      2379 # k3s, etcd clients: required if using a "High Availability Embedded etcd" configuration
      2380 # k3s, etcd peers: required if using a "High Availability Embedded etcd" configuration
    ];
    networking.firewall.allowedUDPPorts = [
      8472 # k3s, flannel: required if using multi-node for inter-node networking
    ];
    
    sops.secrets.k3s = {
      sopsFile = ./secrets/k3s-token.yaml;
      key      = "token";
      mode     = "0400";
      owner    = "root";
      group    = "root";
    };
    services.k3s = {
      enable      = true;
      role        = "server";
      clusterInit = true;
      tokenFile   = config.sops.secrets.k3s.path;
    };
  };
}
