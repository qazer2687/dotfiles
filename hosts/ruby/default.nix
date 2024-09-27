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

  # These are configured through home-manager but this
  # option is required so they appear as desktop entries.
  programs.sway.enable = true;
  #programs.hyprland.enable = true;

  programs.fish.enable = true;
  
  # This allows links to be
  # opened across applications.
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    xdgOpenUsePortal = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      #pkgs.xdg-desktop-portal-hyprland
    ];
  };


  networking.hostName = "ruby";

  services.getty.autologinUser = "alex";
  environment.loginShellInit = ''
    [[ "$(tty)" == /dev/tty1 ]] && dbus-run-session sway
  '';

  swapDevices = [
    {
      device = "/swapfile";
      size = 2 * 1024;
    }
  ];

  environment = {
    systemPackages = with pkgs; [
      # Put system packages here...
    ];
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
      MOZ_ENABLE_WAYLAND = "1";
      XDG_SESSION_TYPE = "wayland";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      # This option scales menu bars, causing
      # them to appear way too large.
      # GDK_SCALE = "2";
    };
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

    nh.enable = true;
  };

  # Did you read the comment?
  system.stateVersion = "23.05";
}
