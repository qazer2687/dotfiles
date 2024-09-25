{pkgs, lib, ...}: {
  imports = [
    ../../hardware/jet
    ../../modules/nixos
  ];

  networking.hostName = "jet";

  users.users = {
    alex = {
      initialPassword = "xela";
      isNormalUser = true;
      extraGroups = ["networkmanager" "wheel" "video" "audio"];
      shell = pkgs.fish;
    };
  };

  #? Stop the power button from
  #? shutting down the machine.
  services.logind.extraConfig = ''
    HandlePowerKey=ignore
    HandleSuspendKey=ignore
    HandleHibernateKey=ignore
  '';

  #? These are configured through home-manager but this
  #? option is required so they appear as desktop entries.
  programs.sway.enable = true;
  #programs.hyprland.enable = true;

  programs.fish.enable = true;
  
  #? This allows links to be
  #? opened across applications.
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    xdgOpenUsePortal = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      #pkgs.xdg-desktop-portal-hyprland
    ];
  };

  hardware = {
    graphics = {
      enable = true;
    };
    asahi = {
      withRust = true;
      useExperimentalGPUDriver = true;
      #? Using the driver mode breaks sway and using the
      #? overlay mode fails to compile so I can only use
      #? the replace mode, but it makes my config impure.
      experimentalGPUInstallMode = "replace";
      setupAsahiSound = true;
      peripheralFirmwareDirectory = ../../firmware/jet;
    };
  };

  boot = {
    kernelParams = [
      "apple_dcp.show_notch=1" #? Enables the pixels horizontal of the notch.
      "kernel.nmi_watchdog=0"
      "fbcon=nodefer"
      "bgrt_disable"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=0"
      "udev.log_priority=2"
      "vt.global_cursor_default=0"
      "mitigations=off"
      "quiet"
    ];
    initrd.verbose = false;
    consoleLogLevel = 0;
    m1n1CustomLogo = ../../assets/m1n1CustomLogo.png;
  };

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
      #? Put system packages here...
    ];
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
      MOZ_ENABLE_WAYLAND = "1";
      XDG_SESSION_TYPE = "wayland";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      #? This option scales menu bars, causing
      #? them to appear way too large.
      #? GDK_SCALE = "2";
    };
  };

  modules = {
    core.enable = true;
    networkmanager.enable = true;
    bluetooth.enable = true;
    #? Sound is managed via the setupAsahiSound option
    #? and I do not need easyeffects installed on Jet.
    #pipewire.enable = true;
    systemd-boot.enable = true;
    filesystem.enable = true;
    zram.enable = true;
    nh.enable = true;
  };

  # Did you read the comment?
  system.stateVersion = "24.11";
}
