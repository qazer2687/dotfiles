{...}: {
  imports = [
    ../../hardware/jet
    ../../hardware/jet/apple-silicon-support # required for asahi
    ../../modules/nixos
  ];

  # Asahi
  hardware.asahi = {
    withRust = true;
    useExperimentalGPUDriver = true;
    experimentalGPUInstallMode = "replace"; # driver breaks sway, overlay fails to compile, replace doesn't work in pure eval
    setupAsahiSound = true;
    peripheralFirmwareDirectory = ../../firmware/jet;
  };
  boot = {
    kernelParams = [
      "apple_dcp.show_notch=1" # enable notch pixel space on asahi
    ];
  };

  # Autologin
  services.getty.autologinUser = "alex";
  environment.loginShellInit = ''
    [[ "$(tty)" == /dev/tty1 ]] && sway
  '';

  # Swap
  swapDevices = [{
    device = "/swapfile";
    size = 16 * 1024;
  }];

  # Environment Variables
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    XDG_CURRENT_DESKTOP = "sway";
    XDG_SESSION_TYPE = "wayland";
  };
  
  # Modules
  modules = {
    networkmanager.enable = true;

    # sound is managed by hardware.asahi.setupAsahiSound
    # this will install easyeffects with its plugins
    pipewire.enable = true;

    systemd-boot.enable = true;
    bluetooth.enable = true;
    filesystem.enable = true;
    fonts.enable = true;
    keymap.enable = true;
    zram.enable = true;

    # Utilities
    nh.enable = true;
  };

  # Did you read the comment?
  system.stateVersion = "24.11";
}
