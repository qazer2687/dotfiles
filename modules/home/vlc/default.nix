{
  lib,
  pkgs,
  config,
  ...
}: {
  options.modules.vlc.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.vlc.enable {
    home.packages = with pkgs; [
      vlc
    ];
  };
}
