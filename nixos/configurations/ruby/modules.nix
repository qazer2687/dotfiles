{...}: {
  imports = [
    ../../modules
  ];

  systemModules = {
    user.alex.enable = true;
    pipewire.enable = true;
    systemd-boot.enable = true;
    colemak.enable = true;
    fonts.enable = true;
    libinput.enable = true;
    logind.enable = true;
    gnome-keyring.enable = true;
    networkmanager.enable = true;
    tlp.enable = true;
    fstrim.enable = true;
    polkit.enable = true;
    opengl.enable = true;

    kernel = {
      enable = true;
      type = "stable";
    };

    zram = {
      enable = true;
      percentage = 20;
    };

    sway = {
      enable = true;
      host = "ruby";
    };
  };
}
