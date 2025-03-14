{
  lib,
  config,
  ...
}: {
  options.modules.server.matrix.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.server.matrix.enable {
    services.matrix-conduit = {
      enable = true;

      settings.global = {
        address = "127.0.0.1";
        port = 8008;
        # Tailscale MagicDNS
        server_name = "opal.taila82ec7.ts.net";

        # Set this to false when initializing.
        allow_registration = true;
        allow_encryption = true;
        registration_token = "f3d0dd56";
        database_backend = "rocksdb";
      };
    };
  };
}
