{
  lib,
  config,
  pkgs,
  ...
}: {
  options.modules.theme.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.theme.enable {
    dconf = {
      enable = true;
      settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
    };
    home.sessionVariables = {
      GTK_THEME = "Adwaita-dark";
      #QT_SCALE_FACTOR = "2";
      #ELM_SCALE = "2";
      #GDK_SCALE = "2";
      XCURSOR_SIZE=90;
    };
    gtk = {
      enable = true;
      iconTheme = {
        name = "Adwaita";
        package = pkgs.adwaita-icon-theme;
      };
      theme = {
        name = "Adwaita-dark";
        package = pkgs.gnome-themes-extra;
      };
      gtk3.extraConfig = {gtk-application-prefer-dark-theme = 1;};
      gtk4.extraConfig = {gtk-application-prefer-dark-theme = 1;};
    };
    qt = {
      enable = true;
      platformTheme.name = "adwaita";
      style.name = "adwaita-dark";
    };
    home.pointerCursor = {
      gtk.enable = true;
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 22;
    };
  };
}
