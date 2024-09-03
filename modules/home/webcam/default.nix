{
  lib,
  config,
  pkgs,
  ...
}: let
  webcam = pkgs.writeShellApplication {
    name = "webcam";
    runtimeInputs = with pkgs; [
      mpv
    ];
    text = ''
      mpv av://v4l2:/dev/video0 --profile=low-latency --untimed --no-osc --no-input-default-bindings --cache=no --vf=hflip > /dev/null 2>&1 &
    '';
  };
in {
  options.modules.webcam.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.webcam.enable {
    home.packages = [ webcam ];
  };
}