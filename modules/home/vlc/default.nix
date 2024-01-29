{
  lib,
  pkgs,
  config,
  ...
}: {
  options.homeModules.vlc.enable = lib.mkEnableOption "";

  config = lib.mkIf config.homeModules.vlc.enable {
    home.packages = with pkgs; [
      vlc
    ];
  };
}
