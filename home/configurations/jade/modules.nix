{...}: {
  imports = [
    ../../modules
  ];

  homeModules = {
    bash.jade.enable = true;
    direnv.enable = true;
    git.enable = true;
    neovim.enable = true;
    spicetify.enable = true;
    firefox.enable = true;
    armcord.enable = true;
    vscode.jade.enable = true;
    alacritty.jade.enable = true;
    polybar.jade.enable = true;
    dunst.jade.enable = true;
    i3.jade.enable = true;
    spotifyd.enable = true;
  };
}
