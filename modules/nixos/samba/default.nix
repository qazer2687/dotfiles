{
  lib,
  config,
  ...
}: {
  options.modules.samba.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.samba.enable {
    services.samba = {
      enable = true;
      openFirewall = true;
      settings = {
        global = {
          # Allow local network and tailnet.
          "hosts allow" = "192.168.0. localhost 100.64.0.0/10";
          "hosts deny" = "0.0.0.0/0";
          "guest account" = "alex";
          "map to guest" = "bad user";
        };
        samba = {
          "path" = "/mnt/external/media";
          "read only" = "yes";
          "guest ok" = "yes";
          # Hide the downloads folder.
          "veto files" = "/downloads/";
        };
      };
    };

    # Allow network discovery.
    services.samba-wsdd = {
      enable = true;
      openFirewall = true;
      interface = "tailscale0";
    };

    # No idea what this does.
    services.avahi = {
      publish.enable = true;
      publish.userServices = true;
      # ^^ Needed to allow samba to automatically register mDNS records (without the need for an `extraServiceFile`
      nssmdns4 = true;
      # ^^ Not one hundred percent sure if this is needed- if it aint broke, don't fix it
      enable = true;
      openFirewall = true;
    };

    networking.firewall.enable = true;
    networking.firewall.allowPing = true;
  };
}