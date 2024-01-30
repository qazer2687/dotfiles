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
      name = "Fluent-dark";
      package = pkgs.fluent-icon-theme;
    };
    theme = {
      name = "Fluent-dark";
      package = pkgs.fluent-gtk-theme;
    };
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
  };

  home.stateVersion = "23.05";
  home.homeDirectory = "/home/alex";

  sops.defaultSopsFile = ../../../secrets/default.yaml;
  sops.age.sshKeyPaths = ["/home/alex/.ssh/id_ed25519"];
}