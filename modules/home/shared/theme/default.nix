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
        # This targets GTK2 and GTK3 specifically. 
        # adw-gtk3 is designed to make GTK3 apps look like GTK4 Libadwaita.
        name = "adw-gtk3-dark"; 
        package = pkgs.adw-gtk3;
      };
      
      gtk3.extraConfig = {
        gtk-application-prefer-dark-theme = 1; # Use 1 for boolean in GTK ini
      };
      
      gtk4.extraConfig = {
        gtk-application-prefer-dark-theme = 1;
      };
    };

    # This ensures GTK4/Libadwaita apps (which ignore themes) 
    # are forced into dark mode via dconf.
    dconf.settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
    };
  };
}