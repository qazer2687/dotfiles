{
  lib,
  config,
  pkgs,
  ...
}: {
  options.modules.utilities.enable = lib.mkEnableOption "";

  # This is a special module that contains
  # any custom utilities/scripts that I make.

  config = lib.mkIf config.modules.utilities.enable {
    home.packages = let
      utilities = [
        (pkgs.writeShellApplication {
          name = "webcam";
          runtimeInputs = with pkgs; [mpv];
          text = ''
            mpv av://v4l2:/dev/video0 --profile=low-latency --untimed --no-osc --no-input-default-bindings --cache=no --vf=hflip > /dev/null 2>&1 &
          '';
        })
        (pkgs.writeShellApplication {
          name = "screenshot";
          runtimeInputs = with pkgs; [
            grim
            slurp
            wl-clipboard
          ];
          text = ''
            grim -g "$(slurp -b 00000055 -c ffffffff)" - | wl-copy -t image/png
          '';
        })
      ];
    in
      utilities;
  };
}
