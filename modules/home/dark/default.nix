{
  lib,
  config,
  pkgs,
  self,
  ...
}: {
  options.modules.dark.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.dark.enable {
    dconf = {
      enable = true;
      settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
    };
    home.sessionVariables.GTK_THEME = "Adwaita-dark";
    gtk = {
      enable = true;
      iconTheme = {
        name = "Adwaita";
        package = self.packages.adwaita-icon-theme;
      };
      theme = {
        name = "Adwaita-dark";
        package = self.packages.gnome-themes-extra;
      };
      gtk3.extraConfig = {gtk-application-prefer-dark-theme = 1;};
      gtk4.extraConfig = {gtk-application-prefer-dark-theme = 1;};
    };
    qt = {
      enable = true;
      platformTheme.name = "adwaita";
      style.name = "adwaita-dark";
    };
  };
}
