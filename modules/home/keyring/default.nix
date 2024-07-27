{
  lib,
  config,
  pkgs,
  self,
  ...
}: {
  options.modules.keyring.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.keyring.enable {
    services.gnome-keyring = {
      enable = true;
      components = [
        "secrets"
      ];
    };
    home.packages = with self.packages; [
      gnome.seahorse
    ];
  };
}
