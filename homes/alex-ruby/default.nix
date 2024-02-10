{pkgs, ...}: {
  imports = [
    ../../modules/home
  ];

  home.packages = with pkgs; [
    firefox
    obsidian
    gnome.nautilus
    qbittorrent
    foliate
    gammastep
  ];

  # Dark Mode
  home.sessionVariables.GTK_THEME = "Adwaita-dark";
  gtk = {
    enable = true;
    iconTheme = {
      name = "Adwaita";
      package = pkgs.gnome.adwaita-icon-theme;
    };
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome.gnome-themes-extra;
    };
    gtk3.extraConfig = {gtk-application-prefer-dark-theme = 1;};
  };
  qt = {
    enable = true;
    platformTheme = "gnome";
    style.name = "adwaita-dark";
  };

  modules = {
    # Environment
    sway.enable = true;
    waybar.enable = true;
    foot.enable = true;
    git.enable = true;

    # Development
    vscode.enable = true;
  };

  home.stateVersion = "23.05";
  home.homeDirectory = "/home/alex";

  sops.defaultSopsFile = ../../../secrets/default.yaml;
  sops.age.sshKeyPaths = ["/home/alex/.ssh/id_ed25519"];
}
