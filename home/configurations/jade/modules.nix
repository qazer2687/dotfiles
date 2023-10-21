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
    spotifyd.enable = true;
    obsidian.enable = true;

    #temp
    vscode.enable = true;
    waybar.enable = true;
    
    armcord.enable = true;
    vlc.enable = true;
    
    #vscode = {
    #  enable = true;
    #  host = "jade";
    #};

    #waybar = {
    #  enable = true;
    #  host = "jade";
    #};

    foot = {
      enable = true;
      host = "jade";
    };

  };
}
