{
  pkgs,
  ...
}: {
  imports = [
    ./modules.nix
  ];
  
  home.stateVersion = "23.05";
  home.homeDirectory = "/home/alex";
  sops.age.sshKeyPaths = ["$HOME/.ssh/id_ed25519"];
}
