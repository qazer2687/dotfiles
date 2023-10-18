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
    vscode.ruby.enable = true;
    foot.ruby.enable = true;
    waybar.ruby.enable = true;
  };
}
