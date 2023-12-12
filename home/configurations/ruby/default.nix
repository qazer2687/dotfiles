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
    waybar.ruby.enable = true;
    gtk.enable = true;
    eza.enable = true;
    starship.enable = true;
    bash.enable = true;

    foot = {
      enable = true;
      host = "ruby";
    };
  };
}
