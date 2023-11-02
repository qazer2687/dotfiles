{ ...}: {
  imports = [
    ../../../hardware/citrine
    ../../modules
  ];

  # NETWORKING
  networking.hostName = "citrine";

  # MODULES
  systemModules = {
    user.alex.enable = true;
    grub.enable = true;
    colemak.enable = true;
    networkmanager.enable = true;
    kernel = {
      enable = true;
      type = "latest";
    };
  };
}
