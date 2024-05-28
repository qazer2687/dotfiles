{pkgs, ...}: {
  imports = [
    ../../hardware/jade
    ../../modules/nixos
  ];

  networking.hostName = "jade";
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  # startx
  #services.xserver.enable = true;
  #services.xserver.displayManager.startx.enable = true;
  #environment.loginShellInit = ''
  #  [[ "$(tty)" == /dev/tty1 ]] && startx
  #'';

  environment = {
    loginShellInit = ''
    [[ "$(tty)" == /dev/tty1 ]] && sway
  '';
    defaultPackages = lib.mkForce [];
    sessionVariables = {
      # wayland support
      WLR_NO_HARDWARE_CURSORS = "1";
      MOZ_ENABLE_WAYLAND = "1";
      NIXOS_OZONE_WL = "1";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
      GBM_BACKEND = "nvidia-drm";
    };
  };

  # autologin
  services.getty.autologinUser = "alex";

  # Modules
  modules = {
    kernel.enable = true;
    networkmanager.enable = true;
    nvidia.enable = true;
    pipewire.enable = true;
    systemd-boot.enable = true;
    steam.enable = true;
    filesystem.enable = true;
  };

  # State Version
  system.stateVersion = "23.05";
}
