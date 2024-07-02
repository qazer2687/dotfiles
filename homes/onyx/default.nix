{pkgs, ...}: {
  imports = [
    ../../modules/home
  ];

  home.packages = with pkgs; [
    
  ];

  modules = {
    # Environment

    alacritty.enable = true;
    git.enable = true;

    firefox.enable = true;
    fish.enable = true;


    # Development


  };

  home.stateVersion = "24.05";
  home.homeDirectory = "/home/alex";

  sops.defaultSopsFile = ../../../secrets/default.yaml;
  sops.age.sshKeyPaths = ["/home/alex/.ssh/id_ed25519"];
}
