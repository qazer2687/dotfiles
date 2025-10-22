{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: {
  options.modules.flatpak.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.flatpak.enable {
    services.flatpak = {
      enable = true;
      packages = [
        "com.github.tchx84.Flatseal"
        "org.vinegarhq.Sober"
        "com.usebottles.bottles"
      ];
      overrides = {
        global = {
          # Force Wayland by default.
          Context.sockets = ["wayland" "!x11" "!fallback-x11"];

          Environment = {
            # Fix un-themed cursor in some Wayland apps.
            XCURSOR_PATH = "/run/host/user-share/icons:/run/host/share/icons";

            # Force correct theme for some GTK apps.
            GTK_THEME = "Adwaita:dark";
          };
        };
      };
      update.auto = {
        enable = true;
        onCalendar = "daily";
      };
    };
  };
}
