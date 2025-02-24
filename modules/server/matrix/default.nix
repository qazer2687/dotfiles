{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: {
  options.modules.server.matrix.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.server.matrix.enable {
    # See https://search.nixos.org/options?channel=unstable&query=services.matrix-conduit.
    # and https://docs.conduit.rs/configuration.html
    services.matrix-conduit = {
      enable = true;
      settings.global = {
        allow_registration = true;
        registration_token = "f3d0dd56";
        server_name = "matrix.opal";
        address = "::1";
        database_backend = "rocksdb";
      };
    };
  };
}
