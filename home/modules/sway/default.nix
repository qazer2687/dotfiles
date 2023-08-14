

{
  pkgs,
  lib,
  inputs,
  config,
  ...
}: {

  options.homeModules.spicetify.enable = lib.mkEnableOption "";

  config = lib.mkIf config.homeModules.spicetify.enable {
    wayland.windowManager.sway = {
      enable = true;
      systemd.enable = true;
      xwayland = false;
      config = rec {
        modifier = "Mod4";
        terminal = "foot"; 
        fonts.size = lib.mkForce 0.0;
        floating.border = 1;
        window.border = 0;
        # tbc


    };
  };
}