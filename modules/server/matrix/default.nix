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
        registration_token = "f3d0dd560091aa99d8e97e48b36e73924e14b8b50a39280b5df751c5394b9a15";
        server_name = "opal";
        address = "::1";
        database_backend = "rocksdb";
      };
    };
  };
}
