{
  lib,
  config,
  pkgs,
  ...
}: {
  options.systemModules.security.keepassxc.enable = lib.mkEnableOption "";

  config = lib.mkIf config.systemModules.security.keepassxc.enable {
    # Installation
    environment.systemPackages = with pkgs; [
      keepassxc
      git-credential-keepassxc
    ];
  };
}
