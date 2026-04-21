{
  lib,
  config,
  pkgs,
  ...
}: {
  options.modules.theme.enable = lib.mkEnableOption "";
  config = lib.mkIf config.modules.theme.enable {
    home.pointerCursor = {
      gtk.enable = true;
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 16;
    };

    gtk = {
      enable = true;

      theme = {
        name = "Catppuccin-GTK-Dark";
        package = pkgs.magnetic-catppuccin-gtk;
      };

      gtk3 = {
        extraConfig = {
          gtk-application-prefer-dark-theme = 1;
        };
      };

      gtk4 = {
        theme = config.gtk.theme;
        extraConfig = {
          gtk-application-prefer-dark-theme = 1;
        };
      };
    };

    xdg.configFile = let
      themeDir = "${pkgs.magnetic-catppuccin-gtk}/share/themes/Catppuccin-GTK-Dark-hdpi/gtk-4.0";
    in {
      "gtk-4.0/gtk.css".source = "${themeDir}/gtk.css";
      "gtk-4.0/gtk-dark.css".source = "${themeDir}/gtk-dark.css";
      "gtk-4.0/assets" = {
        source = "${themeDir}/assets";
        recursive = true;
      };
    };

    dconf.settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
    };
  };
}
