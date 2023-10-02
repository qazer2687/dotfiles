{
  lib,
  config,
  ...
}: {
  options.systemModules.user.alex.enable = lib.mkEnableOption "";
  options.systemModules.user.oli.enable = lib.mkEnableOption "";

  config = lib.mkMerge [
    (lib.mkIf config.systemModules.user.alex.enable {
      users.users.alex = {
        isNormalUser = true;
        home = "/home/alex";
        extraGroups = ["networkmanager" "wheel" "video"];
        #passwordFile = config.sops.secrets.users_alex_password.path;
      };
    })
    (lib.mkIf config.systemModules.user.oli.enable {
      users.users.oli = {
        isNormalUser = true;
        home = "/home/oli";
        extraGroups = ["networkmanager" "wheel" "video"];
        #passwordFile = config.sops.secrets.users_oli_password.path;
      };
    })
  ];
}