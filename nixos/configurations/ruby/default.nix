{...}: {
  imports = [
    ../../../hardware/ruby
    ../../modules
  ];

  networking.hostName = "ruby";

  users.users.alex = {
    isNormalUser = true;
    extraGroups = ["networkmanager" "wheel" "video" "storage"];
  };

  environment.etc = {
    issue = {
      text = ''\e[31mWelcome to Ruby!\e[0m'';
    };
  };

  environment.loginShellInit = ''
    [[ "$(tty)" == /dev/tty1 ]] && sway
  '';

  systemModules = {
    pipewire.enable = true;
    easyeffects.enable = true;
    systemd-boot.enable = true;
    colemak.enable = true;
    fonts.enable = true;
    libinput.enable = true;
    gnome-keyring.enable = true;
    networkmanager.enable = true;
    tlp.enable = true;
    fstrim.enable = true;
    polkit.enable = true;
    opengl.enable = true;
    kernel.enable = true;
    zram.enable = true;
    sway.enable = true;
  };
}
