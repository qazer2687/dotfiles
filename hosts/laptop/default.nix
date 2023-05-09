{ config, pkgs, inputs, nixos-06cb-009a-fingerprint-sensor, ... }:

{
  # Imports
  imports = [
    ./hardware-configuration.nix
    ./config/polybar/default.nix
    ./config/i3/default.nix
    ./config/alacritty/default.nix
    ./config/silentboot/stage2.nix
    ./config/silentboot/silent.nix
  ];

  # State Version
  system.stateVersion = "22.11";

  # Unfree Software
  nixpkgs.config.allowUnfree = true;

  # Nix Experimental Commands
  nix.settings.experimental-features = [ "nix-command" ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  boot.plymouth.enable = true;
  boot.plymouth.theme = "bgrt";
  
  # Fingerprint Drivers
  services.open-fprintd.enable = true;
  services.python-validity.enable = true;

  # Pam Authentication
  security.pam.services.sudo.text = ''
    account required pam_unix.so
    auth sufficient ${nixos-06cb-009a-fingerprint-sensor.localPackages.fprintd-clients}/lib/security/pam_fprintd.so
    auth sufficient pam_unix.so   likeauth try_first_pass nullok
    auth required pam_deny.so
    password sufficient pam_unix.so nullok sha512
    session required pam_env.so conffile=/etc/pam/environment readenv=0
    session required pam_unix.so
  '';

  # Networking
  networking.hostName = "nixpad";
  networking.networkmanager.enable = true;
  
  # Xorg
  services.xserver = {
    enable = true;
    
    # Login Manager
    displayManager.gdm.enable = true;

    # Window Manager
    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-rounded;
    };
    
    # Input Drivers
    libinput.enable = true;
  };

  # Audio
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  
  # Users
  users.users.alex = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # Keyboard
  console.keyMap = "colemak";
  services.xserver = {
    layout = "gb";
    xkbVariant = "colemak";
  };

  # Locale
  time.timeZone = "Europe/London";
  i18n.defaultLocale = "en_GB.UTF-8";

  # Fonts
  fonts.fonts = with pkgs; [( nerdfonts.override {
    fonts = [
      "FiraCode" 
    ];
  })];

  # Home Manager
  home-manager.users.alex = {

    # State Version (HM)
    home.stateVersion = "22.11";

    # Packages
    home.packages = with pkgs; [
      obsidian
      neofetch
      firefox
      dotnet-sdk_7
      dotnetPackages.Nuget
      ghc
#     ncmpcpp
      anki-bin
      vscodium
      polybarFull
      dmenu
      scrot
      redshift
      brightnessctl
      feh
      networkmanagerapplet
      pavucontrol
      pamixer
      alacritty
      gnome.nautilus
    ];

    # Neovim
    programs.neovim = {
      enable = true;
      vimAlias = true;
      plugins = with pkgs.vimPlugins; [
        vim-nix
      ];
    };

    # MPD
    services.mpd = {
      enable = false;
      musicDirectory = "/home/alex/Music";
      extraConfig = ''
        audio_output {
          type            "pulse"
          name            "pulse"
          mixer_type      "hardware"
          mixer_device    "default"
          mixer_control   "PCM"
          mixer_index     "0"
        }
      '';
    };
  };
}
