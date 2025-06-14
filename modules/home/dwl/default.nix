{
  lib,
  config,
  pkgs,
  osConfig,
  ...
}: let
  screenshot = pkgs.writeShellApplication {
    name = "screenshot";
    runtimeInputs = with pkgs; [
      grim
      slurp
      wl-clipboard
    ];
    text = ''
      grim -g "$(slurp -b 00000055 -c ffffffff)" - | wl-copy -t image/png
    '';
  };
in {
  options.modules.dwl.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.dwl.enable {
    home.packages = with pkgs; [
      (pkgs.dwl.override {
        configH = if osConfig.networking.hostName == "jet"
          then ./config/jet/config.h
          else ./config/jade/config.h;
        enableXWayland = if osConfig.networking.hostName == "jet"
          then false
          else true;
      })
      swaybg
      brightnessctl
      pamixer
      screenshot
      wlr-randr
      waypipe
    ];
  };
}
