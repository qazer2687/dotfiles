{...}: {
  imports = [
    ../../../hardware/ruby
    ../../modules
  ];

  # NETWORKING
  networking.hostName = "ruby";

  # ENVIRONMENT
  environment.sessionVariables = {
    NIXPKGS_ALLOW_UNFREE = "1"; # Allow Unfree 'nix-shell' Packages
  };

  # USER
  users.users.alex = {
    isNormalUser = true;
    extraGroups = ["networkmanager" "wheel" "video" "storage"];
  };

  # MODULES
  systemModules = {
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
