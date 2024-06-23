{...}: {
  imports = [
    ../../hardware/ruby
    ../../modules/nixos
  ];

  networking.hostName = "ruby";
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  environment.etc = {
    issue = {
      text = ''\e[31mWelcome to Ruby!\e[0m'';
    };
  };

# environment.loginShellInit = ''
#    [[ "$(tty)" == /dev/tty1 ]] && sway
#  '';

##### temp
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

  # Modules
  modules = {
    kernel.enable = true;
    networkmanager.enable = true;
    pipewire.enable = true;
    systemd-boot.enable = true;
    bluetooth.enable = true;
    tlp.enable = true;
    filesystem.enable = true;
  };

  system.stateVersion = "23.05";
}
