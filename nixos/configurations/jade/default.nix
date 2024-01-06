{...}: {
  imports = [
    ../../../hardware/jade
    ../../modules
  ];

  networking.hostName = "jade";

  users.users.alex = {
    isNormalUser = true;
    extraGroups = ["networkmanager" "wheel" "video"];
  };

  environment.loginShellInit = ''
    [[ "$(tty)" == /dev/tty1 ]] && i3
  '';

  systemModules = {
    pipewire.enable = true;
    easyeffects.enable = true;
    systemd-boot.enable = true;
    udev.via.enable = false;
    colemak.enable = true;
    fonts.enable = true;
    i3.enable = true;
    gamemode.enable = true;
    lutris.enable = true;
    steam.enable = true;
    prismlauncher.enable = true;
    opengl.enable = true;
    nvidia.enable = true;
    kernel.enable = true;
    zram.enable = true;
    fstrim.enable = true;
    piper.enable = true;
    networkmanager.enable = true;
    polkit.enable = true;
    gnome-keyring.enable = true;
  };
}
