{pkgs, ...}: {
  imports = [
    ../../modules/home
  ];

  home.packages = with pkgs; [
    obsidian
    gnome.nautilus
    obs-studio
    armcord
    lunar-client
    vlc
  ];

  modules = {
    # Environment
    i3.enable = true;
    alacritty.enable = true;
    git.enable = true;
    dark.enable = true;
    neovim.enable = true;
    firefox.enable = true;
    fish.enable = true;
    polybar.enable = true;
    dunst.enable = true;

    # Development
    vscode.enable = true;

    # Gaming
    prismlauncher.enable = true;
  };

  home.stateVersion = "23.05";
  home.homeDirectory = "/home/alex";

  sops.defaultSopsFile = ../../../secrets/default.yaml;
  sops.age.sshKeyPaths = ["/home/alex/.ssh/id_ed25519"];
}
