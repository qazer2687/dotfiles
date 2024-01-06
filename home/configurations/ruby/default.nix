{...}: {
  imports = [
    ../../modules
  ];

  homeModules = {
    direnv.enable = true;
    git.enable = true;
    neovim.enable = true;
    vscode.enable = true;
    firefox.enable = true;
    obsidian.enable = true;
    foot.enable = true;
    eza.enable = true;
    starship.enable = true;
    bash.enable = true;
    gammastep.enable = true;
    waybar.enable = true;
    gtk.enable = true;
  };
}
