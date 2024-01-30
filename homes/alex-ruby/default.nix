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
  
  # Dark Mode (GTK4)
  programs.dconf.enable = true;
  dconf = {
    enable = true;
    settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
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