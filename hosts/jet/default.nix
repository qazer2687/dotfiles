{...}: {
  imports = [
    ../../hardware/jet
    ../../hardware/jet/apple-silicon-support # required for asahi
    ../../modules/nixos
  ];

  hardware.asahi.peripheralFirmwareDirectory = ../../firmware/jet;
  hardware.asahi.useExperimentalGPUDriver = true;

  networking.hostName = "jet";

  # autologin
  services.getty.autologinUser = "alex";

  environment.loginShellInit = ''
    [[ "$(tty)" == /dev/tty1 ]] && sway
  '';

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    XDG_CURRENT_DESKTOP = "sway";
    XDG_SESSION_TYPE = "wayland";
  };

  hardware.asahi.setupAsahiSound = true;

  boot = {
    kernelParams = [
      "apple_dcp.show_notch=1" # enable notch pixel space on asahi
    ];
  };

  # Modules
  modules = {
    networkmanager.enable = true;
    # pipewire.enable = true; # sound is managed by asahi-sound
    systemd-boot.enable = true;
    bluetooth.enable = true;
    filesystem.enable = true;
    fonts.enable = true;
    keymap.enable = true;
    zram.enable = true;
  };

  system.stateVersion = "24.11";
}
