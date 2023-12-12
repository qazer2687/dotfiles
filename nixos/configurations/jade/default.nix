{ ...}: {
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
    prismlauncher.enable = true;
    steam.enable = true;
    opengl.enable = true;
    piper.enable = true;

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

    gdm = {
      enable = true;
      backend = "xorg";
    };

    # Games
    vinegar.enable = true;
  };
}
