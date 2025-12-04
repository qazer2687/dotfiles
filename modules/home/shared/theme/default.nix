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

    home-manager.users.alex = {
      dconf = {
        enable = true;
        settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
      };
    };
    
    # Don't use gtk.enable, configure files directly
    home.packages = with pkgs; [
      gnome-themes-extra
      adwaita-icon-theme
    ];
    
    xdg.configFile."gtk-3.0/settings.ini".text = ''
      [Settings]
      gtk-theme-name=Adwaita-dark
      gtk-icon-theme-name=Adwaita
      gtk-cursor-theme-name=Bibata-Modern-Ice
      gtk-cursor-theme-size=16
      gtk-application-prefer-dark-theme=true
    '';
    
    xdg.configFile."gtk-4.0/settings.ini".text = ''
      [Settings]
      gtk-theme-name=Adwaita-dark
      gtk-icon-theme-name=Adwaita
      gtk-cursor-theme-name=Bibata-Modern-Ice
      gtk-cursor-theme-size=16
      gtk-application-prefer-dark-theme=true
    '';
    
    home.sessionVariables = {
      GTK_THEME = "Adwaita-dark";
    };
  };
}