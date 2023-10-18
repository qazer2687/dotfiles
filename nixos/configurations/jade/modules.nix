{...}: {
  imports = [
    ../../modules
  ];

  systemModules = {
    user.alex.enable = true;
    pipewire.enable = true;
    easyeffects.enable = true;
    systemd-boot.enable = true;
    colemak.enable = true;
    fonts.enable = true;
    libinput.enable = true;
    zram.enable = true;
    gnome-keyring.enable = true;
    networkmanager.enable = true;
    udev.via.enable = false;
    fstrim.enable = true;
    nvidia.enable = true;
    sway.ruby.enable = true;
    opengl.enable = true;
    polkit.enable = true;

    kernel = {
      enable = true;
      type = "zen";
    };
  };
}
