{ ...}: {
  imports = [
    ../../../hardware/citrine
    ../../modules
  ];

  # NETWORKING
  networking.hostName = "citrine";

  # USER
  users.users.alex = {
    isNormalUser = true;
    extraGroups = ["networkmanager" "wheel" "video"];
  };

  # MODULES
  systemModules = {
    grub.enable = true;
    colemak.enable = true;
    networkmanager.enable = true;
    kernel = {
      enable = true;
      type = "latest";
    };
  };
}
