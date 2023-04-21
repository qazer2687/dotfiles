{ config, pkgs, ... }:

{
  # Imports
  imports = [
    ./hardware-configuration.nix
    ./config/polybar/default.nix
    ./config/i3/default.nix
    ./config/alacritty/default.nix
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
  
  # ZRam
  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 50;
  };

  # Networking
  networking.hostName = "desktop";
  networking.networkmanager.enable = true;
  
  # Xorg
  services.xserver = {
    enable = true;
    
    # Graphics Drivers
    videoDrivers = [ "nvidia" ];

    # Login Manager
    displayManager.gdm.enable = true;

    # Window Manager
    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-rounded;
    };

    # Input Drivers
    libinput = {
      enable = true;
      mouse.accelProfile = "flat";
      mouse.accelSpeed = "0";
    };
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

  # System-Wide Steam (Required)
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  # OpenGL Libraries (For Steam)
  hardware.opengl.enable = true;

  # Org.Freedesktop.Secrets (For Git)
  services.gnome.gnome-keyring.enable = true;

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

      # General
      firefox
      discord
      neofetch
      obs-studio
      vlc

      # Programming (Languages)
      vscodium
      ghc          # Haskell
      dotnet-sdk_7 # C#
      gcc          # C
      rustup       # Rust
      php          # PHP
      clisp        # Common Lisp

      # Programming (Extras)
      dotnetPackages.Nuget

      # Gaming
      grapejuice
      osu-lazer

      # Environment
      polybarFull
      dmenu
      scrot
      feh
      pavucontrol
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
    
    # Git
    programs.git = {
    enable = true;
    userName = "***REMOVED***";
    userEmail = "***REMOVED***@outlook.com";
    };
  };
}
