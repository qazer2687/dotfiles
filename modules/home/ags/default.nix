{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: {
  options.modules.ags.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.ags.enable {
    programs.ags = {
      enable = true;
    
      configDir = ./config;

      extraPackages = with pkgs; [
        astal.hyprland
        astal.mpris
        astal.battery
        astal.network
        #astal.tray # broken
      ];
    };
  };
}
