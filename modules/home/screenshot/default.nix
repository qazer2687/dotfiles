{
  lib,
  config,
  pkgs,
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
  options.modules.screenshot.enable = lib.mkEnableOption "";
  config = lib.mkIf config.modules.screenshot.enable {
    home.packages = with pkgs; [screenshot];
  };
}
