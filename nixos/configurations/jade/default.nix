{pkgs, ...}: {
  imports = [
    ../../../hardware/jade
    ../../modules
  ];

  # NETWORKING
  networking.hostName = "jade";

  # USER
  users.users.alex = {
    isNormalUser = true;
    extraGroups = ["networkmanager" "wheel" "video"];
  };

  # PACKAGES
  environment.systemPackages = with pkgs; [
    wineWowPackages.staging
  ];

  # MODULES
  systemModules = {
    pipewire.enable = true;
    easyeffects.enable = true;
    systemd-boot.enable = true;
    colemak.enable = true;
    fonts.enable = true;
    libinput.enable = true;
    gnome-keyring.enable = true;
    networkmanager.enable = true;
    udev.via.enable = false;
    fstrim.enable = true;
    polkit.enable = true;
    i3.enable = true;

    kernel = {
      enable = true;
      type = "latest";
    };

    zram = {
      enable = true;
      percentage = 20;
    };

    nvidia = {
      enable = true;
      driver = "stable";
    };

    opengl = {
      enable = true;
    };

    gdm = {
      enable = true;
      backend = "xorg";
    };
  };
}
