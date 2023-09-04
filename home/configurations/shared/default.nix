{
  lib,
  ...
}: {
  imports = [
    ./modules.nix
  ];
  
  home.stateVersion = "23.05";
  home.homeDirectory = mkDefault "/home/alex";
  sops.defaultSopsFile = ../../../secrets/default.yaml;
  sops.age.sshKeyPaths = ["/home/alex/.ssh/id_ed25519"];
}