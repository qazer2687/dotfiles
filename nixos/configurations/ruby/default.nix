{...}: {
  imports = [
    ../../../hardware/ruby
    ../../modules
  ];

  # NETWORKING
  networking.hostName = "ruby";

  # USER
  users.users.alex = {
    isNormalUser = true;
    extraGroups = ["networkmanager" "wheel" "video" "storage"];
  };

  # Startup Message
  environment.etc = {
    issue = {
      text = ''\e[31mWelcome to Ruby!\e[0m'';
    };
  };

  # No Login Manager
  environment.loginShellInit = ''
    [[ "$(tty)" == /dev/tty1 ]] && sway
  '';

  # MODULES
  systemModules = {
    # Audio
    pipewire.enable = true;
    easyeffects.enable = true;

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
      type = "latest";
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
