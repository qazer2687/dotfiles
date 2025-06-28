{...}: {
  imports = [
    ../../hardware/amber
    ../../modules/base
  ];

  users.users.alex = {
    isNormalUser = true;
    extraGroups = ["networkmanager" "wheel" "video"];
    hashedPassword = "$6$qRDf73LqqlnrtGKd$fwNbmyhVjAHfgjPpM.Wn8YoYVbLRq1oFWN15fjP3b.cVW8Dv3s/7q8NY4WBYY7x1Xe71S.AHpuqL1PY6IJe0x1";
  };

  # Hostname
  networking.hostName = "amber";

  modules = {
    kernel.enable = true;
    pipewire.enable = true;
    fonts.enable = true;
    keymap.enable = true;
    zram.enable = true;
  };

  # Unknown because this isn't installed yet, set to latest on install.
  system.stateVersion = "23.05";
}
