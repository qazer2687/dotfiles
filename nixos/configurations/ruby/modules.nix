{...}: {
  imports = [
    ../../modules
  ];

  systemModules = {
    pipewire.enable = true;
    systemd-boot.enable = true;
    colemak.enable = true;
    fonts.enable = true;
    libinput.enable = true;
    logind.enable = true;
    gnome-keyring.enable = true;
    networkmanager.enable = true;
    kernel.ruby.enable = true;
    tlp.enable = true;
    fstrim.enable = true;
    polkit.enable = true;
    opengl.enable = true;
    sway.ruby.enable = true;
  };
}
