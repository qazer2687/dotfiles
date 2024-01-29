{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ../../../modules/home
  ];

  home.packages = with pkgs; [
    firefox
    obsidian
    vscodium-fhs
    gnome.nautilus
  ];

  modules = {
    # Environment
    i3.enable = true;
    polybar.enable = true;
    alacritty.enable = true;

    # Gaming
    prismlauncher.enable = true;
  };

  home.stateVersion = mkDefault "23.05";
  home.homeDirectory = mkDefault "/home/alex";

  sops.defaultSopsFile = ../../../secrets/default.yaml;
  sops.age.sshKeyPaths = ["/home/alex/.ssh/id_ed25519"];
}