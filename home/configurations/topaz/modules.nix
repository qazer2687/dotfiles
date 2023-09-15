{...}: {
  imports = [
    ../../modules
  ];

  homeModules = {
    direnv.enable = true;
    git.enable = true;
    neovim.enable = true;
    chromium.enable = true;
    alacritty.enable = true;
  };
}
