{pkgs, ...}: {
  imports = [
    ../../modules/home
  ];

  home.packages = with pkgs; [
    firefox
    obsidian
    gnome.nautilus
    foliate
    gammastep
    fragments
  ];

  modules = {
    # Environment
    sway.enable = true;
    waybar.enable = true;
    foot.enable = true;
    git.enable = true;
    theme.enable = true;

    # Development
    vscode.enable = true;
  };

  home.stateVersion = "23.05";
  home.homeDirectory = "/home/alex";

  sops.defaultSopsFile = ../../../secrets/default.yaml;
  sops.age.sshKeyPaths = ["/home/alex/.ssh/id_ed25519"];
}
