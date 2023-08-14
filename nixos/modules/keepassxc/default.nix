{
  lib,
  config,
  pkgs,
  ...
}: {
  options.systemModules.keepassxc.enable = lib.mkEnableOption "";

  config = lib.mkIf config.systemModules.keepassxc.enable {
    # Installation
    environment.systemPackages = with pkgs; [
      keepassxc
      git-credential-keepassxc
    ];
  };
}
