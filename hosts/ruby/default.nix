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

  environment.loginShellInit = ''
    [[ "$(tty)" == /dev/tty1 ]] && sway
  '';

  users.users.alex = {
    isNormalUser = true;
    extraGroups = ["networkmanager" "wheel" "video"];
  };

  # Gnome Keyring
  services.gnome.gnome-keyring.enable = true;

  modules = {
    kernel.enable = true;
    networkmanager.enable = true;
    pipewire.enable = true;
    systemd-boot.enable = true;
    zram.enable = true;
    tlp.enable = true;
  };
}
