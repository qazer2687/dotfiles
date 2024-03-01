{pkgs, ...}: {
  imports = [
    ../../modules/home
  ];

  home.packages = with pkgs; [
    firefox
    obsidian
    gnome.nautilus
    obs-studio
  ];

  modules = {
    # Environment
    i3.enable = true;
    polybar.enable = true;
    alacritty.enable = true;
    git.enable = true;
    theme.enable = true;

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
