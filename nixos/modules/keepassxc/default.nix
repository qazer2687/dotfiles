{
  lib,
  config,
  pkgs,
  ...
}: {
  options.systemModules.keepassxc.enable = lib.mkEnableOption "";

  config = lib.mkIf config.systemModules.keepassxc.enable {
    environment.systemPackages = with pkgs; [
      keepassxc
      git-credential-keepassxc
    ];
  };
}
