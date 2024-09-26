{
  pkgs,
  ...
}: {
  imports = [
    ../../hardware/ruby
    ../../modules/nixos
  ];

  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  users.users = {
    alex = {
      initialPassword = "xela";
      isNormalUser = true;
      openssh.authorizedKeys.keys = [
        # TODO: Add your SSH public key(s) here...
      ];
      extraGroups = ["networkmanager" "wheel" "video" "audio"];
      shell = pkgs.fish;
    };
  };

  programs.fish.enable = true;

  environment.etc = {
    issue = {
      text = ''\e[31mWelcome to Ruby!\e[0m'';
    };
  };

  # Hostname
  networking.hostName = "ruby";

  # SSH
  services.openssh.enable = true;
  networking.firewall.allowedTCPPorts = [
    22 # SSH
  ];

  # environment.loginShellInit = ''
  #    [[ "$(tty)" == /dev/tty1 ]] && sway
  #  '';


  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

  # Modules
  modules = {
    core.enable = true;
    networkmanager.enable = true;
    pipewire.enable = true;
    systemd-boot.enable = true;
    bluetooth.enable = true;
    filesystem.enable = true;
    zram.enable = true;

    # Utilities
    nh.enable = true;
  };

  # Did you read the comment?
  system.stateVersion = "23.05";
}
