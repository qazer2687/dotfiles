{
  lib,
  config,
  pkgs,
  osConfig,
  ...
}: {
  options.modules.dwl.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.dwl.enable {
    home.packages = with pkgs; [
      (pkgs.dwl.override {
        configH =
          if osConfig.networking.hostName == "jet"
          then ./config/jet/config.h
          else ./config/jade/config.h;
        enableXWayland =
          if osConfig.networking.hostName == "jet"
          then false
          else true;
      })
      wbg
      brightnessctl
      pamixer
      wlr-randr
    ];
  };
}
