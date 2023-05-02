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
  allowedTCPPorts = [ 80 443 25565 ];
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
      mouse.accelProfile = "flat";
      mouse.accelSpeed = "0";
    };
  };

  # Audio
  ## Pulseaudio [NOT IN USE]
  #sound.enable = true;
  #hardware.pulseaudio.enable = true;
  
  ## Pipewire
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
  
  environment.systemPackages = [
    pkgs.linuxKernel.packages.linux_6_1.v4l2loopback
  ];

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
      droidcam
      obs-studio-plugins.droidcam-obs

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
      prismlauncher
      lunar-client
      lutris

      # Environment
      polybarFull
      dmenu
      scrot
      feh
      pavucontrol
      alacritty
      gnome.nautilus
      easyeffects
      usbmuxd
      
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
    userName = "alexvasilkovski";
    userEmail = "alexvasilkovski@outlook.com";
    };
  };
}
