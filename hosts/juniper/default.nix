{pkgs, config, ...}: {
  imports = [
    ../../hardware/juniper
  ];

  networking.hostName = "juniper";

  users = {
    mutableUsers = false;
    users = {
      root = {
        hashedPassword = "$6$qRDf73LqqlnrtGKd$fwNbmyhVjAHfgjPpM.Wn8YoYVbLRq1oFWN15fjP3b.cVW8Dv3s/7q8NY4WBYY7x1Xe71S.AHpuqL1PY6IJe0x1";
      };
      alex = {
        isNormalUser = true;
        extraGroups = ["networkmanager" "wheel" "video"];
        hashedPassword = "$6$qRDf73LqqlnrtGKd$fwNbmyhVjAHfgjPpM.Wn8YoYVbLRq1oFWN15fjP3b.cVW8Dv3s/7q8NY4WBYY7x1Xe71S.AHpuqL1PY6IJe0x1";
        shell = pkgs.fish;
      };
    };
  };

  programs.fish.enable = true;

  boot = {
    kernelParams = [
      "quiet"

      # https://wiki.cachyos.org/configuration/general_system_tweaks/#enable-rcu-lazy
      "rcutree.enable_rcu_lazy=1"
    ];
    initrd.verbose = false;
    consoleLogLevel = 0;
    kernelPackages = pkgs.linuxPackages_cachyos-server;
  };

  # Support for vscode remote server.
  programs.nix-ld.enable = true;

    environment = {
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
      MOZ_ENABLE_WAYLAND = "1";
      XDG_SESSION_TYPE = "wayland";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      AMD_VULKAN_ICD = "RADV";

      # Picked up by gamescope session.
      XKB_DEFAULT_LAYOUT = "us";
      XKB_DEFAULT_VARIANT = "colemak";
    };
    # Required for nix-flatpak to work. Not in home-manager because of gmodena/nix-flatpak#33.
    systemPackages = [pkgs.flatpak pkgs.firefox];
  };

  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  modules = {
    core.enable = true;
    dbus.enable = true;
    nh.enable = true;
    sudo-rs.enable = true;
    systemd-boot.enable = true;
    zram.enable = true;
    tailscale.enable = true;

    pipewire.enable = true;
    flatpak.enable = true;
    networkmanager.enable = true;
    xdg.enable = true;
    nvidia.enable = true;

    # Security
    firewall.enable = true;
    chrony.enable = true;
  };

  # Did you read the comment?
  system.stateVersion = "25.05";
}
