{
  pkgs,
  ...
}: {
  imports = [
    ../../modules
  ];

  homeModules = {
    bash.ruby.enable = true;
    direnv.enable = true;
    git.enable = true;
    neovim.enable = true;
    firefox.enable = true;
    webcord.ruby.enable = true;
    vscode.ruby.enable = true;
    foot.ruby.enable = true;
    sway.ruby.enable = true;
    wluma.ruby.enable = true;
    wofi.ruby.enable = true;
  };
   
  home.packages = with pkgs; [
    obsidian # Notes App
  ];

  home.stateVersion = "23.05";
  home.homeDirectory = "/home/alex";
  sops.age.sshKeyPaths = ["$HOME/.ssh/id_ed25519"];
}
