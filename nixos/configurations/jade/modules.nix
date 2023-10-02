{...}: {
  imports = [
    ../../modules
  ];

  systemModules = {
    user.alex.enable = true;
    pipewire.enable = true;
    easyeffects.enable = true;
    systemd-boot.enable = true;
    i3.enable = true;
    colemak.enable = true;
    fonts.enable = true;
    libinput.enable = true;
    zram.enable = true;
    gnome-keyring.enable = true;
    networkmanager.enable = true;
    udev.via.enable = true;
    kernel.jade.enable = true;
    fstrim.enable = true;
    nvidia.enable = true;
    sway.jade.enable = true;
  };
}
