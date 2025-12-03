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
      name = "Bibata-Modern-Ice";
      size = 16;
    };
    
    gtk = {
      enable = true;
      theme = {
        name = "Adwaita-dark";
        package = pkgs.gnome-themes-extra;
      };
      iconTheme = {
        name = "Adwaita";
        package = pkgs.adwaita-icon-theme;
      };
      cursorTheme = {
        name = "Bibata-Modern-Ice";  # Fixed: match pointerCursor
        package = pkgs.bibata-cursors;
      };
      gtk3.extraConfig = {
        gtk-application-prefer-dark-theme = true;
      };
      gtk4.extraConfig = {
        gtk-application-prefer-dark-theme = true;
      };
    };
    
    dconf.settings = {
      "org/gnome/desktop/interface" = {
        gtk-theme = "Adwaita-dark";
        color-scheme = "prefer-dark";
      };
    };
    
    qt = {
      enable = true;
      platformTheme.name = "gtk3";  # Changed from "adwaita"
      style.name = "adwaita-dark";
    };
    
    # Add required packages
    home.packages = with pkgs; [
      qt5.qtwayland
      qt6.qtwayland
      libsForQt5.qtstyleplugins
    ];
  };
}