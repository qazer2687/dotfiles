{
  lib,
  config,
  pkgs,
  osConfig,
  ...
}: {
  options.modules.dwl.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.dwl.enable {
    programs.dwl = {
      enable = true;
      package = (pkgs.dwl.override {
        configH = if osConfig.networking.hostName == "jet"
          then ./config/jet/config.h
          else ./config/jade/config.h;
        enableXWayland = if osConfig.networking.hostName == "jet"
          then false
          else true;
      });
    };
    
    home.packages = with pkgs; [
      wbg
      brightnessctl
      pamixer
      wlr-randr
    ];
  };
}
