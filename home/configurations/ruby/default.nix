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

    vscode = {
      enable = true;
      host = "ruby";
    };

    foot = {
      enable = true;
      host = "ruby";
    };

    waybar = {
      enable = true;
      host = "ruby";
    };

    armcord.enable = true;
  };
}
