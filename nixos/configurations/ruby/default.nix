{...}: {
  imports = [
    ../../../hardware/ruby
    ../../modules
  ];

  # NETWORKING
  networking.hostName = "ruby";

  # ENVIRONMENT
  environment.sessionVariables = {
    #NIXOS_OZONE_WL = "1"; # Wayland Electron Support
    #MOZ_ENABLE_WAYLAND = "1"; # Wayland Firefox Support
    #GTK_USE_PORTAL = "0"; # Waybar Startup Delay Fix
    NIXPKGS_ALLOW_UNFREE = "1"; # Allow Unfree 'nix-shell' Packages
  };

  # MODULES
  systemModules = {
    user.alex.enable = true;
    pipewire.enable = true;
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

    gdm = {
      enable = true;
      backend = "wayland";
    };
  };
}
