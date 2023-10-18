{
  lib,
  pkgs,
  ...
}: {
  options.homeModules.vlc.enable = lib.mkEnableOption "";

  config = {
    homeModules.vlc.enable = {
      home.packages = with pkgs; [
        vlc
      ];
    };
  };
}
