{...}: {
  containers.homepage-dashboard = {
    autoStart = true;
    privateNetwork = true;
    cfg = { config, pkgs, lib, ... }: {

      

      networking = {
        firewall = {
          enable = true;
          allowedTCPPorts = [ 80 ];
        };
        # Use systemd-resolved inside the container
        # Workaround for bug https://github.com/NixOS/nixpkgs/issues/162686
        useHostResolvConf = mkForce false;
      };
      
      services.resolved.enable = true;
    };
  };
}