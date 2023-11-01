{
  lib,
  config,
  pkgs,
  ...
}: {
  options.systemModules.sway.enable = lib.mkEnableOption "";

  options.systemModules.sway.host = lib.mkOption {
    default = "";
    type = lib.types.str;
    description = "Choose the host-specific configuration. (e.g. 'jade' or 'ruby')";
  };

  config = lib.mkIf config.systemModules.sway.enable {
    programs.sway = {
      enable = true;
      wrapperFeatures.gtk = true;

      # Use SwayFX Package
      package = pkgs.swayfx.overrideAttrs (_old: {passthru.providedSessions = ["sway"];});

      # Install Additional Packages
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

    # XDG (broken, causes firefox and waybar 'very' slow startup)
    xdg.portal = {
      enable = false;
    };

    # Copy Sway Configuration Into /etc
    environment.etc."sway/config".source = ./config/${config.systemModules.sway.host};
  };
}
