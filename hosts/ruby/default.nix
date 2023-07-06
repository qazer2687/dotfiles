{ config, pkgs, inputs, ... }:
{
  # Imports
  imports = [
    
    # Configurations
    ./configs/polybar/default.nix
    ./configs/i3/default.nix
    ./configs/alacritty/default.nix
    ./hardware-configuration.nix

    # Modules
    ../../modules/default.nix

  ];

  modules = {
    boot = {
      systemd-boot.enable = true;
      silentboot.enable = true;
    };
    desktop = {
      autologin.enable = true;
      i3.enable = true;
    };
    network = {
      networkmanager.enable = true;
    };
    audio = {
      pipewire.enable = true;
    };
    misc = {
      colemak.enable = true;
      fonts.enable = true;
      keyring.enable = true;
      mouseaccel.enable = true;
      zram.enable = true;
    };
  };

  # State Version
  system.stateVersion = "23.05";

  # Unfree Software
  nixpkgs.config.allowUnfree = true;

  # Nix Experimental Commands
  nix.settings.experimental-features = [ "nix-command" ];

  # Hostname
  networking.hostName = "ruby";

  # Users
  users.users.alex = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # Locale
  time.timeZone = "Europe/London";
  i18n.defaultLocale = "en_GB.UTF-8";

  # Home Manager
  home-manager.users.alex = {

    # State Version (HM)
    home.stateVersion = "23.05";

    # Packages
    home.packages = with pkgs; [

      # General
      firefox           # Web Browser
      discord           # Communication Client
      
      # Programming
      vscodium          # Code IDE
      ghc               # Haskell
      dotnet-sdk_7      # C#
      rustc
      cargo

      # Productivity
      obsidian          # Note-Taking App
      anki-bin          # Flashcard App

      # Environment
      dunst             # Notification Daemon
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
    userName = "***REMOVED***";
    userEmail = "***REMOVED***@outlook.com";
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
