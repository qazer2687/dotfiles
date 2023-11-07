{...}: {
  imports = [
    ../../modules
  ];

  sops.secrets.spotify_password.path = "/home/alex/.config/spotifyd/password";

  homeModules = {
    direnv.enable = true;
    git.enable = true;
    neovim.enable = true;
    firefox.enable = true;
    spicetify.enable = true;
    obs.enable = true;
    spotifyd.enable = true;
    obsidian.enable = true;
    vscode.jade.enable = true;
    polybar.enable = true;
    armcord.enable = true;
    rider.enable = true;
    vlc.enable = true;
    alacritty.enable = true;
    i3.jade.enable = true;
    dunst.enable = true;
  };
}
