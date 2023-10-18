{...}: {
  imports = [
    ../../modules
  ];

  homeModules = {
    direnv.enable = true;
    git.enable = true;
    neovim.enable = true;
    firefox.enable = true;
    spicetify.enable = true;
    obs.enable = true;
    vscode.jade.enable = true;
    spotifyd.enable = true;
    obsidian.enable = true;
    foot.ruby.enable = true;
    sway.jade.enable = true;
    waybar.ruby.enable = true;
  };
}
