{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ../../modules/home
  ];

  home.packages = with pkgs; [
    obsidian
    nautilus
    obs-studio
    lunar-client
    vlc
    vesktop
  ];

  modules = {
    # Environment
    i3.enable = true;
    alacritty.enable = true;
    git.enable = true;
    dark.enable = true;
    firefox.enable = true;
    fish.enable = true;
    polybar.enable = true;
    dunst.enable = true;


    # Development
    vscode.enable = true;
    emacs.enable = true;

    # Gaming
    prismlauncher.enable = true;
  };

  home.stateVersion = "23.05";
  home.homeDirectory = lib.mkForce "/home/alex";

  sops.defaultSopsFile = ../../../secrets/default.yaml;
  sops.age.sshKeyPaths = ["/home/alex/.ssh/id_ed25519"];
}
