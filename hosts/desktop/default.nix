{ config, pkgs, ... }:

{
  # Imports
  imports = [

    # Package Configuration
    ./config/polybar/default.nix
    ./config/minecraft/default.nix
    ./config/i3/default.nix
    ./config/alacritty/default.nix
    
    # Hardware Configuration
    ./hardware-configuration.nix
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
  networking.firewall = {
  enable = true;
  allowedTCPPorts = [ 80 443 25565 ]; # HTTP, HTTPS, Minecraft
  allowedUDPPortRanges = [
    { from = 4000; to = 4007; }
    { from = 8000; to = 8010; }
  ];
};

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
      mouse.accelProfile = "flat"; # Remove Mouse Accel
      mouse.accelSpeed = "0"; # Remove Mouse Accel
    };
  };

  # Audio
  sound.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  
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

  # Steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };
  hardware.opengl.enable = true;

  # Secrets
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
      firefox           # Web Browser
      discord           # Communication Platform
      betterdiscordctl  # Discord Tweaks
      neofetch          # System Stats
      obs-studio        # Recording Software
      vlc               # Video Player

      # Programming
      vscodium
      ghc               # Haskell
      dotnet-sdk_7      # C#
      gcc               # C
      rustup            # Rust
      php               # PHP
      clisp             # Common Lisp

      # Gaming
      grapejuice        # Roblox
      osu-lazer         # OSU
      prismlauncher     # Minecraft (Modded)
      lunar-client      # Minecraft (Hypixel)
      lutris            # Overwatch

      # Environment
      polybarFull       # System Bar
      dmenu             # System Search
      scrot             # Screenshot Utility
      feh               # Wallpaper Utility
      pavucontrol       # Audio Interface
      alacritty         # Terminal Emulator
      gnome.nautilus    # File Browser
      easyeffects       # Audio Equaliser
      dxvk_2            # Vulkan Translation Layer
      
    ];

    # Neovim Text Editor
    programs.neovim = {
      enable = true;
      vimAlias = true;
      plugins = with pkgs.vimPlugins; [
        vim-nix
      ];
    };
    
    # Git Version Control
    programs.git = {
    enable = true;
    userName = "alexvasilkovski";
    userEmail = "alexvasilkovski@outlook.com";
    };
  };
}

