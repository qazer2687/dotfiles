{...}: {
  imports = [
    ../../hardware/amber
    ../../modules/nixos
  ];

  users.users.alex = {
    isNormalUser = true;
    extraGroups = ["networkmanager" "wheel" "video"];
  };

  # Hostname
  networking.hostName = "amber";


  modules = {
    kernel.enable = true;
    systemd-boot.enable = true;
    pipewire.enable = true;
    fonts.enable = true;
    keymap.enable = true;
    zram.enable = true;
  };

  # Unknown because this isn't installed yet, set to latest on install.
  system.stateVersion = "23.05";
}
