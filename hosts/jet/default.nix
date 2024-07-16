{...}: {
  imports = [
    ../../hardware/jet
    ../../hardware/jet/apple-silicon-support # required for asahi
    ../../modules/nixos
  ];

  hardware.asahi.peripheralFirmwareDirectory = ../../firmware/jet;
  hardware.asahi.useExperimentalGPUDriver = true;

  networking.hostName = "jet";

  environment.etc = {
    issue = {
      text = ''\e[31mWelcome to Jet!\e[0m'';
    };
  };

  environment.loginShellInit = ''
    [[ "$(tty)" == /dev/tty1 ]] && sway
  '';

  hardware.asahi.setupAsahiSound = true;

  # Modules
  modules = {
    kernel.enable = true;
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
