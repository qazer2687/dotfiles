{pkgs, ...}: {
  imports = [
    ../../modules
  ];

  homeModules = {
    programs = {
      bash.enable = true;
      direnv.enable = true;
      git.enable = true;
      neovim.enable = true;
      spicetify.enable = true;
      firefox.enable = true;
      discord.jade.enable = true;
      vscode.jade.enable = true;
      alacritty.jade.enable = true;
      polybar.jade.enable = true;
      dunst.jade.enable = true;
      i3.jade.enable = true;
    };
    services = {
      spotifyd.enable = true;
    };
  };

  home.packages = with pkgs; [
    # General
    obs-studio
    vlc

    # Programming
    alejandra
    deadnix
    statix

    # Gaming
    osu-lazer-bin
    prismlauncher
    lunar-client
    lutris
    protonup-qt

    # Environment
    dmenu
    scrot
    feh
    pavucontrol
    gnome.nautilus
    neofetch
    redshift
  ];

  home.stateVersion = "23.05";
  home.homeDirectory = "/home/alex";
  sops.secrets.spotify_password.path = "/home/alex/.config/spotifyd/password";
  sops.defaultSopsFile = ../../../secrets/default.yaml;
  sops.age.sshKeyPaths = ["/home/alex/.ssh/id_ed25519"];
}
