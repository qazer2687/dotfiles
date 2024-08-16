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
  ];

  # arRPC
  ## This allows the use of Discord rich
  ## presence via Vencord on firefox.
  services.arrpc.enable = true;

  modules = {
    # Environment
    sway.enable = true;
    waybar.enable = true;
    foot.enable = true;
    mako.enable = true;
    wofi.enable = true;
    theme.enable = true;
    firefox.enable = true;
    fish.enable = true;
    keyring.enable = true;

    # CLI Tools
    bat.enable = true;
    eza.enable = true;

    # Development
    vscode.enable = true;
    git.enable = true;
    direnv.enable = true;
  };

  home.stateVersion = "24.11";
  home.homeDirectory = lib.mkForce "/home/alex";

  sops.defaultSopsFile = ../../../secrets/default.yaml;
  sops.age.sshKeyPaths = ["/home/alex/.ssh/id_ed25519"];
}
