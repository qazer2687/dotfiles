{ config, pkgs, inputs, ... }:

{
  # Imports
  imports = [

    # Hardware
    ./hardware-configuration.nix

    # Configs
    ./configs/polybar/default.nix
    ./configs/i3/default.nix
    ./configs/alacritty/default.nix

    # Tweaks
    ./tweaks/silent/stage2.nix
    ./tweaks/silent/default.nix
    ./tweaks/zram/default.nix

    # Services
    ./services/minecraft/default.nix

  ];

  # State Version
  system.stateVersion = "22.11";

  # Unfree Software
  nixpkgs.config.allowUnfree = true;

  # Nix Experimental Options
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  # Nix Other Options
  nix.extraOptions = ''
    keep-outputs = true
    keep-derivations = true
  '';

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  
  # Networking
  networking.hostName = "jade";
  networking.networkmanager.enable = true;
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 80 443 25565 ]; # SSH, HTTP, HTTPS, MC
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
  
  # OpenGL
  hardware.opengl.enable = true;
  hardware.opengl.driSupport32Bit = true;

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
      obs-studio        # Recording Software
      vlc               # Video Player
      espanso           # Text Expander

      # Programming
      vscodium          # Code IDE
      ghc               # Haskell
      dotnet-sdk_7      # C#
      gcc               # C
      rustup            # Rust
      php               # PHP
      clisp             # Common Lisp
      jdk8              # Java
      R                 # Rlang

      # Gaming
      steam             # Game Launcher
      osu-lazer         # OSU
      prismlauncher     # Minecraft (Modded)
      lunar-client      # Minecraft (Hypixel)
      lutris            # Overwatch
      wine-staging      # Latest Wine Version
      protonup-qt       # Tweaked Wine Version

      # Environment
      polybarFull       # System Bar
      dmenu             # System Search
      scrot             # Screenshot Utility
      feh               # Wallpaper Utility
      pavucontrol       # Audio Interface
      alacritty         # Terminal Emulator
      cinnamon.nemo     # File Manager
      easyeffects       # Audio Equaliser
      speex             # Noise Cancellation
      neofetch          # System Stats
      
    ];

    # Text Editor
    programs.neovim = {
      enable = true;
      vimAlias = true;
      plugins = with pkgs.vimPlugins; [
        vim-nix
      ];
    };
    
    # nix-direnv
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
      nix-direnv.enableFlakes = true;
    };
    
    # Git Version Control
    programs.git = {
      enable = true;
      userName = "alexvasilkovski";
      userEmail = "alexvasilkovski@outlook.com";
    };
  };
}
