{ ...}: {
  imports = [
    ../../modules/home
  ];

  modules = {
    alacritty.enable = true;
    git.enable = true;
    fish.enable = true;
    starship.enable = true;
    direnv.enable = true;
  };

  home.stateVersion = "24.05";
  home.homeDirectory = "/Users/alex";

  sops.defaultSopsFile = ../../../secrets/default.yaml;
  sops.age.sshKeyPaths = ["/home/alex/.ssh/id_ed25519"];
}
