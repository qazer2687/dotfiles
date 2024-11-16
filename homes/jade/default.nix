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
    obs-studio
    lunar-client
    vlc
    vesktop
  ];

  /*
  services.flatpak.packages = [
    # Can't install from flatpakref.
    # https://github.com/gmodena/nix-flatpak/issues/78
  ];
  */

  modules = {
    # Environment
    i3.enable = true;
    alacritty.enable = true;
    git.enable = true;
    theme.enable = true;
    firefox.enable = true;
    fish.enable = true;
    polybar.enable = true;
    dunst.enable = true;
    keyring.enable = true;

    # Development
    vscode.enable = true;
    emacs.enable = true;
    direnv.enable = true;

    # Gaming
    #prismlauncher.enable = true;
    #mangohud.enable = true;

    # Experimental
    sway.enable = true;
    hyprland.enable = true;
    waybar.enable = true;
    foot.enable = true;
    mako.enable = true;
    wofi.enable = true;
  };

  home.stateVersion = "23.05";
  home.homeDirectory = lib.mkForce "/home/alex";

  sops.defaultSopsFile = ../../../secrets/secrets.yaml;
  sops.age.sshKeyPaths = ["/home/alex/.ssh/id_ed25519"];
}
