{...}: {
  imports = [
    ../../../hardware/citrine
    ../../modules
  ];

  networking.hostName = "citrine";

  users.users.alex = {
    isNormalUser = true;
    extraGroups = ["networkmanager" "wheel" "video"];
  };

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
