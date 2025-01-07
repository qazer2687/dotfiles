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

  # Stop the power button from
  # shutting down the machine.
  services.logind.extraConfig = ''
    HandlePowerKey=ignore
    HandleSuspendKey=ignore
    HandleHibernateKey=ignore
  '';

  # These are configured through home-manager but this
  # option is required so they appear as desktop entries.
  #programs.sway.enable = true;
  #programs.hyprland.enable = true;
  #programs.niri.enable = true;

  programs.fish.enable = true;
  
  # This allows links to be
  # opened across applications.
  xdg.portal = {
    enable = true;
    #wlr.enable = lib.mkForce true;
    #xdgOpenUsePortal = true;
    #extraPortals = [
      #pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gtk
    #];
    # Fix 'xdg-desktop-portal 1.17 reworked how
    # portal implementations are loaded' warning.
    #config.common.default = "*";
  };

  hardware = {
    graphics = {
      enable = true;
    };
    asahi = {
      withRust = true;
      useExperimentalGPUDriver = true;
      # Using the driver mode breaks sway and using the
      # overlay mode fails to compile so I can only use
      # the replace mode, but it makes my config impure.
      experimentalGPUInstallMode = "replace";
      setupAsahiSound = true;
      peripheralFirmwareDirectory = ../../firmware/jet;
    };
  };

  boot = {
    kernelParams = [
      # Enables the pixels horizontal of the notch.
      "apple_dcp.show_notch=1"
      "quiet"
      # Redirect console messages.
      "console=tty3"
      # Disable cursor to stop blinking.
      "vt.global_cursor_default=0"
      # Wipe the vendor logo earlier.
      "fbcon=nodefer"
    ];
    initrd.verbose = false;
    consoleLogLevel = 0;
    #m1n1CustomLogo = ../../assets/m1n1CustomLogo.png;
  };

  # Hide the 'File descriptor leaked on LVM invocation' warning on boot.
  environment.etc."lvm/lvm.conf".text = ''
    devices {
        suppress_fd_warnings = 1;
    }
    logging {
        level = 0;
    }
  '';

  # Autologin and hide getty messages.
  services.getty = {
    autologinUser = "alex";
    extraArgs = [
      "--skip-login"
      "--nonewline"
      "--noissue"
      "--noclear"
    ];
  };
  environment.loginShellInit = ''
    [[ "$(tty)" == /dev/tty1 ]] && dbus-run-session niri
  '';

  swapDevices = [
    {
      device = "/swapfile";
      size = 4 * 1024;
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
      # Temporary fix for nautilus not launching on hyprland.
      # https://bbs.archlinux.org/viewtopic.php?pid=2196562#p2196562
      GSK_RENDERER = "ngl";
      # Temporary fix for the cursor being offset slightly.
      # https://github.com/hyprwm/Hyprland/issues/7244
      AQ_NO_ATOMIC = "0";
    };
  };
  
  modules = {
    core.enable = true;
    bluetooth.enable = true;
    # Sound is managed via the setupAsahiSound option
    # and I do not need easyeffects installed on Jet.
    #pipewire.enable = true;
    systemd-boot.enable = true;
    filesystem = {
      enable = true;
      apfsSupport = true;
    };
    zram.enable = true;
    tailscale.enable = true;
  };

  # Did you read the comment?
  system.stateVersion = "24.11";
}
