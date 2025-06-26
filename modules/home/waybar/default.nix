{
  lib,
  config,
  pkgs,
  osConfig,
  ...
}: {
  options.modules.waybar.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.waybar.enable {
    wayland.windowManager.sway.config.bars = [
      {
        command = "${pkgs.waybar}/bin/waybar";
      }
    ];

    home.packages = with pkgs; [
      # MPRIS Dependency
      playerctl
    ];

    programs.waybar = {
      enable = true;
      systemd.enable = false;
    };

    xdg.configFile =
      if osConfig.networking.hostName == "jet"
      then {
        "waybar/config".source = ./config/jet/config.json;
        "waybar/style.css".source = ./config/jet/style.css;
      }
      else {
        "waybar/config".source = ./config/jade/config.json;
        "waybar/style.css".source = ./config/jade/style.css;
      };
  };
}
