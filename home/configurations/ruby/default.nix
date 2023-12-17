{...}: {
  imports = [
    ../../modules
  ];

  homeModules = {
    direnv.enable = true;
    git.enable = true;
    neovim.enable = true;
    gammastep.enable = true;
    firefox.enable = true;
    obsidian.enable = true;
    vscode.enable = true;
    waybar.enable = true;
    gtk.enable = true;
    eza.enable = true;
    starship.enable = true;
    bash.enable = true;
    foot.enable = true;
    spotifyd.enable = true;
  };
}
