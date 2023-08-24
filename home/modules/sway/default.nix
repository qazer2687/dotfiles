

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
      package = pkgs.swayfx;
      enable = true;
      systemd.enable = true;
      xwayland = false;
      extraPackages = with pkgs; [
        swayidle
        waybar
        mako 
        kanshi
        wofi
      ];
    };

    xdg.configFile."sway/config".text = builtins.readFile ./config/laptop;
  };
}