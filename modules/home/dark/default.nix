{
  lib,
  config,
  pkgs,
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
        name = "adwaita";
        package = pkgs.gnome.adwaita-icon-theme;
      };
      theme = {
        name = "adwaita-dark";
        package = pkgs.gnome.gnome-themes-extra;
      };
      gtk3.extraConfig = {gtk-application-prefer-dark-theme = 1;};
      gtk4.extraConfig = {gtk-application-prefer-dark-theme = 1;};
    };
    # i have no idea if this does anything
    systemd.user.sessionVariables = config.home-manager.users.alex.home.sessionVariables;
    qt = {
      enable = true;
      platformTheme.name = "adwaita";
      style.name = "adwaita-dark";
    };
  };
}
