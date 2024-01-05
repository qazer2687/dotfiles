{...}: {
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
    # Audio
    pipewire.enable = true;
    easyeffects.enable = true;

    # Boot
    systemd-boot.enable = true;
    udev.via.enable = false;

    # Customization
    colemak.enable = true;
    fonts.enable = true;

    # Desktop Environment
    i3.enable = true;
    gdm.enable = true;

    # Gaming
    gamemode.enable = true;
    lutris.enable = true;
    steam.enable = true;
    prismlauncher.enable = true;

    # Graphics
    opengl.enable = true;
    nvidia.enable = true;

    # System
    kernel = {
      enable = true;
      type = "zen";
    };
    zram = {
      enable = true;
      percentage = 50;
    };

    # Other
    fstrim.enable = true;
    piper.enable = true;
    networkmanager.enable = true;
    polkit.enable = true;
    gnome-keyring.enable = true;
  };
}
