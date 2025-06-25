{
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ../../modules/home
  ];

  home.packages = with pkgs; [
    obsidian
    nautilus
    obs-studio
    vlc
    vesktop
    loupe
    mumble

    ncdu
    btop
    
    lunar-client

    # Misc
    ffmpeg-full
    libheif
    
    vinegar
  ];
  
  # Rich presence support for vesktop.
  services.arrpc.enable = true;

  modules = {
    # Desktop Environment
    dwl.enable = true;
    waybar.enable = true;
    mako.enable = true;
    tofi.enable = true;
    theme.enable = true;
    
    # CLI
    fish.enable = true;
    foot.enable = true;
    fastfetch.enable = true;
    eza.enable = true;
    zoxide.enable = true;
    screenshot.enable = true;

    # Gaming
    mangohud.enable = true;
    prismlauncher.enable = true;
    
    firefox.enable = true;
    
    xdg.enable = true;
    

    # Development
    direnv.enable = true;
    git.enable = true;
    zed.enable = true;
  };

  home.stateVersion = "25.05";
  home.homeDirectory = lib.mkForce "/home/alex";

  sops = {
    defaultSopsFormat = "yaml";
    defaultSopsFile = ../../../secrets/default.yaml;
    age.keyFile = "/home/alex/.config/sops/age/keys.txt";
  };
}
