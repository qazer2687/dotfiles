{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.samba.enable = lib.mkEnableOption "";
  config = lib.mkIf config.modules.samba.enable {
    users.users.samba = {
      isSystemUser = true;
      group = "users";
      # Disable shell access.
      shell = pkgs.shadow;
    };

    services.samba = {
      enable = true;
      settings = {
        global = {
          "hosts allow" = "192.168.0. localhost 100.64.0.0/10";
          "hosts deny" = "0.0.0.0/0";
          "security" = "user";
        };
        shows = {
          path = "/mnt/external/media/shows";
          "read only" = "yes";
          "guest ok" = "yes";
          "browseable" = "yes";
          "valid users" = "samba";
        };
        movies = {
          path = "/mnt/external/media/movies";
          "read only" = "yes";
          "guest ok" = "yes";
          "browseable" = "yes";
          "valid users" = "samba";
        };
      };
    };

    # Automatically set up Samba password on system activation.
    system.activationScripts.samba-password = {
      text = ''
        # Check if samba user exists in Samba database.
        if ! ${pkgs.samba}/bin/pdbedit -L 2>/dev/null | grep -q "^samba:"; then
          echo "Setting up Samba password for user 'samba'..."
          (echo "samba"; echo "samba") | ${pkgs.samba}/bin/smbpasswd -a -s samba
        fi
      '';
      deps = ["users"];
    };
  };
}
