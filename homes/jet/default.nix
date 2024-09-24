{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ../../modules/home
  ];

  home.packages = with pkgs; [
    obsidian
    nautilus
    gammastep
    fragments
    calibre
    vlc
    teams-for-linux
  ];

  modules = {
    sway.enable = true;
    waybar.enable = true;
    foot.enable = true;
    mako.enable = true;
    wofi.enable = true;
    theme.enable = true;
    firefox.enable = true;
    fish.enable = true;
    keyring.enable = true;
    webcam.enable = true;

    bat.enable = true;
    eza.enable = true;

    vscode.enable = true;
    git.enable = true;
    direnv.enable = true;
    neovim.enable = true;

    prismlauncher.enable = true;
  };

  home.stateVersion = "24.11";
  home.homeDirectory = lib.mkForce "/home/alex";

  sops.defaultSopsFile = ../../../secrets/default.yaml;
  sops.age.sshKeyPaths = ["/home/alex/.ssh/id_ed25519"];
}
