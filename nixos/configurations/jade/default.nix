{
  config,
  pkgs,
  lib,
  ...
}: {
  # Imports
  imports = [
    ./hardware-configuration.nix
    ./modules.nix
  ];

  # Hostname
  networking.hostName = "jade";
}
