{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ../../modules/home
  ];

  home.packages = with pkgs; [
    firefox
    obsidian
    vscodium-fhs
    gnome.nautilus

    qbittorrent
    foliate
  ];
  
  # Dark Mode
  gtk = {
    enable = true;
    iconTheme = {
      name = "Adwaita-dark";
      package = pkgs.gnome3.adwaita-icon-theme;
    };
    theme = {
      name = "Fluent-dark";
      package = pkgs.gnome.gnome-themes-extra;
    };
  };
  qt5 = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita-dark";
  };

  modules = {
    # Environment
    sway.enable = true;
    waybar.enable = true;
    foot.enable = true;
  };

  home.stateVersion = "23.05";
  home.homeDirectory = "/home/alex";

  sops.defaultSopsFile = ../../../secrets/default.yaml;
  sops.age.sshKeyPaths = ["/home/alex/.ssh/id_ed25519"];
}