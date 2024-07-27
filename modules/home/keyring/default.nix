{
  lib,
  config,
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
    home.packages = with pkgs; [
      gnome.seahorse
    ];
  };
}
