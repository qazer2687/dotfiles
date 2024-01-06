{
  lib,
  config,
  pkgs,
  ...
}: {
  options.systemModules.sway.enable = lib.mkEnableOption "";

  config = lib.mkIf config.systemModules.sway.enable {
    programs.sway = {
      enable = true;
      wrapperFeatures.gtk = true;

      package = pkgs.swayfx.overrideAttrs (_old: {passthru.providedSessions = ["sway"];});

      extraPackages = with pkgs; [
        brightnessctl
        dmenu-wayland
        mako
        fltk
        grim
        wl-clipboard
        gnome.nautilus
        slurp
        wayland
        gammastep
      ];
    };

    # Waybar#1266
    xdg.portal = {
      enable = false;
    };

    environment.etc."sway/config".source = ./config/ruby;
  };
}
