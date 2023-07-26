{ config, pkgs, inputs, ... }: {
  # Imports
  imports = [
 
     # Common
    ../common
#   ../common/overlays

    # Hardware Configuration
    ./hardware-configuration.nix

    # Software Configuration
    ./configs/polybar
    ./configs/i3
    ./configs/alacritty

    # Modules
    ../../modules

  ];
  
  # Modules
  modules = {
    boot = {
      loader.systemd-boot.enable = true;
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
      firefox
      webcord-vencord
      
      # Programming
      vscodium

      # Productivity
      obsidian

      # Environment
      dunst
      polybarFull
      dmenu
      scrot
      feh
      pavucontrol
      alacritty
      gnome.nautilus
      redshift
      brightnessctl
      pamixer
      neofetch

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
