{
  lib,
  config,
  ...
}: {
  options.modules.samba.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.samba.enable {
    services.samba = {
      enable = true;
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
  };
}
