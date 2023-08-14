{
  pkgs,
  ...
}: {
  imports = [
    ../../modules
  ];

  homeModules = {
    bash.enable = true;
    direnv.enable = true;
    git.enable = true;
    neovim.enable = true;
    firefox.enable = true;
    discord.ruby.enable = true;
    vscode.ruby.enable = true;
    alacritty.ruby.enable = true;
    polybar.ruby.enable = true;
    dunst.ruby.enable = true;
    i3.ruby.enable = true;
  };

  home.packages = with pkgs; [
    # General
    webcord-vencord

    # Productivity
    obsidian

    # Environment
    dmenu
    scrot
    feh
    pavucontrol
    gnome.nautilus
    redshift
    brightnessctl
    pamixer
    neofetch
  ];

  home.stateVersion = "23.05";
  home.homeDirectory = "/home/alex";
  sops.age.sshKeyPaths = ["$HOME/.ssh/id_ed25519"];
}
