{ config, pkgs, lib, ... }:

{
  options.modules.theme.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.theme.enable {
    xdg.portal = {
      enable = true;
      config.common.default = "gtk";
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    };

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
      iconTheme = {
        name = "catppuccin-papirus-folders";  # catppuccin-papirus-folders
        package = pkgs.catppuccin-papirus-folders;
      };
      gtk3.extraConfig = {
        gtk-application-prefer-dark-theme = 1;
      };
      gtk4 = {
        extraConfig = {
          gtk-application-prefer-dark-theme = 1;
        };
      };
    };

    xdg.configFile = let
      themePkg = pkgs.magnetic-catppuccin-gtk;
      themeName = "Catppuccin-GTK-Dark";
      themeDir = "${themePkg}/share/themes/${themeName}/gtk-4.0";
    in {
      "gtk-4.0/assets" = {
        source = "${themeDir}/assets";
        recursive = true;
      };
      "gtk-4.0/gtk.css" = {
        source = "${themeDir}/gtk.css";
      };
      "gtk-4.0/gtk-dark.css" = {
        source = "${themeDir}/gtk-dark.css";
      };
    };

    dconf.settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
        gtk-theme = "Catppuccin-GTK-Dark";
        icon-theme = "catppuccin-papirus-folders";
      };
    };
  };
}