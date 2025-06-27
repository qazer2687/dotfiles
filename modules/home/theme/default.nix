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
        name = "Adwaita";
        package = pkgs.adwaita-icon-theme;
      };
      gtk3 = {
        extraConfig.gtk-application-prefer-dark-theme = true;
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
      platformTheme.name = "adwaita";
      style.name = "adwaita-dark";
    };

    fonts.fontconfig = {
      enable = true;
      antialias = false;
      hinting.enable = true;
    };

    home.packages = with pkgs; [
      noto-fonts-color-emoji
      noto-fonts-cjk-sans

      atkinson-hyperlegible
      agave
      terminus_font
      departure-mono
      eb-garamond
      fixedsys-excelsior
      monaspace
      pragmatapro

      nerd-fonts.fira-code
      nerd-fonts.fira-mono
      nerd-fonts.iosevka
      nerd-fonts.liberation
      nerd-fonts.jetbrains-mono
    ];
  };
}
