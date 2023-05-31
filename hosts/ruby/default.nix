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
    ./tweaks/fingerprint/default.nix

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
  boot.kernelPackages = pkgs.linuxPackages_6_2;
  boot.extraModulePackages = with config.boot.kernelPackages; [
    rtl8812au
  ];

  # Networking
  networking.hostName = "ruby";
  networking.networkmanager.enable = true;
  
  # XWayland Support
  programs.xwayland.enable = true;

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

  # Secrets
  services.gnome.gnome-keyring.enable = true;

  # Fonts
  fonts.fonts = with pkgs; [( nerdfonts.override {
    fonts = [
      "FiraCode"
      "Inconsolata"
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
      
      # Programming
      vscodium          # Code IDE
      ghc               # Haskell
      dotnet-sdk_7      # C#

      # Productivity
      obsidian          # Note-Taking App
      anki-bin          # Flashcard App

      # Environment
      polybarFull       # System Bar
      dmenu             # System Search
      scrot             # Screenshot Utility
      feh               # Wallpaper Utility
      pavucontrol       # Audio Interface
      alacritty         # Terminal Emulator
      gnome.nautilus    # File Manager
      redshift          # Blue Light Filter
      brightnessctl     # Brightness Control
      pamixer           # Volume Control
      neofetch          # System Stats
      image-roll        # Image Viewer

      # Miscellaneous
      libheif   # HEIF Support

    ];

    # Text Editor
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
