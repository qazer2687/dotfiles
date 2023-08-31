{
  ...
}: {
  imports = [
    ../../modules
  ];

  systemModules = {
    pipewire.enable = true;
    easyeffects.enable = true;
    systemd-boot.enable = true;
    gdm.jade.enable = true;
    i3.enable = true;
    steam.enable = true;
    colemak.enable = true;
    fonts.enable = true;
    libinput.enable = true;
    zram.enable = true;
    keepassxc.enable = true;
    gnome-keyring.enable = true;
    networkmanager.enable = true;
    udev.via.enable = true;
    kernel.jade.enable = true;
    fstrim.enable = true;
    nvidia.enable = true;
    opendrop.enable = true;
  };
}