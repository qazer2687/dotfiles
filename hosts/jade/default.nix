{ config, pkgs, inputs, ... }:

{
  # Imports
  imports = [

    # Configs
    ./configs/hardware/hardware-configuration.nix
    ./configs/polybar/default.nix
    ./configs/i3/default.nix
    ./configs/alacritty/default.nix

    # Modules
    ../../modules/default.nix

  ];

  modules = {
    boot = {
      systemd-boot.enable = true;
    };
    desktop = {
      gdm.enable = true;
      i3.enable = true;
    };
    network = {
      networkmanager.enable = true;
    };
    audio = {
      pipewire.enable = true;
    };
    video = {
      nvidia.enable = true;
    };
    gaming = {
      steam.enable = true;
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
  
  # Hostname
  networking.hostName = "jade";

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
    home.stateVersion = "22.11";
    
    # Packages
    home.packages = with pkgs; [

      # General
      firefox               # Web Browser
      discord               # Communication Platform
      betterdiscordctl      # Discord Tweaks
      obs-studio            # Recording Software
      vlc                   # Video Player
      espanso               # Text Expander

      # Programming
      vscodium              # Code IDE

      # Gaming
      steam                 # Game Launcher
      osu-lazer-bin         # OSU
      prismlauncher         # Minecraft (Modded)
      lunar-client          # Minecraft (Hypixel)
      lutris                # Overwatch
      wine-staging          # Latest Wine Version
      protonup-qt           # Tweaked Wine Version

      # Environment
      polybarFull           # System Bar
      dmenu                 # System Search
      scrot                 # Screenshot Utility
      feh                   # Wallpaper Utility
      pavucontrol           # Audio Interface
      alacritty             # Terminal Emulator
      gnome.nautilus        # File Manager
      easyeffects           # Audio Equaliser
      speex                 # Noise Cancellation
      neofetch              # System Stats
      networkmanagerapplet  # Network Configuration
      qpwgraph              # Virtual Patchbay
      
      # Security
      protonvpn-cli         # Virtual Private Network Client
      wireshark             # Packet Analysis Utility
      nmap                  # Port Scanning Utility
      openvpn               # Another VPN Client
      librewolf             # Hardened Firefox Browser
      protonvpn-gui         # GUI for ProtonVPN
      
    ];

    # Text Editor
    programs.neovim = {
      enable = true;
      vimAlias = true;
      plugins = with pkgs.vimPlugins; [
        vim-nix
      ];
    };
    
    # Direnv
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    
    # Bash
    programs.bash.enable = true;
    
    # Automount
    services.udiskie = {
      enable = true;
      notify = false;
    };

    
    # Git Version Control
    programs.git = {
      enable = true;
      userName = "***REMOVED***";
      userEmail = "***REMOVED***@outlook.com";
    };
  };
}
