{...}: {
  # Imports
  imports = [
#    ./hardware-configuration.nix
    ./modules.nix
  ];

  # Hostname
  networking.hostName = "opal";
}
