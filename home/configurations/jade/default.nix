{...}: {
  imports = [
    ../../modules
  ];

  homeModules = {
    direnv.enable = true;
    git.enable = true;
    neovim.enable = true;
    vscode.enable = true;
    rider.enable = false;
    firefox.enable = true;
    armcord.enable = false;
    obsidian.enable = true;
    spicetify.enable = false;
    obs.enable = true;
    vlc.enable = true;
    alacritty.enable = true;
    polybar.enable = true;
    bash.enable = true;
    spotifyd.enable = true;
    mangohud.enable = true;
    i3.jade.enable = true;
    dunst.enable = true;
    gtk.enable = true;
  };
}
