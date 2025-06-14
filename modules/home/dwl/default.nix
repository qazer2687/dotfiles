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
      # The configuration is set in an overlay and defined in the config folder.
      # Enabling this is really just the same as adding dwl to packages but I guess I
      # can add dependencies here.
      (pkgs.dwl.override {
        configH = if osConfig.networking.hostName == "jet"
          then ./config/jet/config.h
          else ./config/jade/config.h;
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
