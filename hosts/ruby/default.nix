{ config, pkgs, inputs, ... }: {
  # Imports
  imports = [
 
     # Common
    ../common/default.nix

    # Hardware Configuration
    ./hardware-configuration.nix

    # Software Configuration
    ./configs/polybar/default.nix
    ./configs/i3/default.nix
    ./configs/alacritty/default.nix
    ./hardware-configuration.nix

    # Modules
    ../../modules/default.nix

  ];
  
  # Modules
  modules = {
    boot = {
      systemd-boot.enable = true;
    };
    desktop = {
      gdm.enable = true;
      gdm.autologin.enable = false;
      i3.enable = true;
    };
    network = {
      networkmanager.enable = true;
      networkmanager.firewall.enable = false;
    };
    audio = {
      pipewire.enable = true;
    };
    video = {
      nvidia.enable = false;
    };
    gaming = {
      steam.enable = false;
    };
    misc = {
      colemak.enable = true;
      fonts.enable = true;
      keyring.enable = true;
      mouseaccel.enable = true;
      zram.enable = true;
      tlp.enable = true;
    };
  };

  # Hostname
  networking.hostName = "ruby";

  # Users
  users.users.alex = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" ];
  };

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
