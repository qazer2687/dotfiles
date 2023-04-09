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
      ncmpcpp
      anki-bin
      discord
      vscodium
      polybarFull
      dmenu
      dunst
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
      enable = true;
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