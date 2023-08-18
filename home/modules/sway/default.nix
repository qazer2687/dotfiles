

{
  pkgs,
  lib,
  inputs,
  config,
  ...
}: {

  options.homeModules.sway.ruby.enable = lib.mkEnableOption "";

  config = lib.mkIf config.homeModules.sway.ruby.enable {
    wayland.windowManager.sway = {
      enable = true;
      systemd.enable = true;
      xwayland = false;
      extraPackages = with pkgs; [
        swayidle
        waybar
        mako 
        kanshi
        swaybg
        wofi
      ];
    };

    xdg.configFile."sway/config".text = builtins.readFile ./config/laptop;
  };
}