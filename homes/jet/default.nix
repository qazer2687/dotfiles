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
    vlc
    loupe

    ncdu
    btop
    
    
    inputs.dwl.packages."${system}".jet
    swaybg
    brightnessctl
    pamixer
    #screenshot
    wlr-randr

    inputs.zen.packages."${system}".default

    ffmpeg-full
    libheif
  ];

  # Enable rich presence support for Discord on the web.
  # services.arrpc.enable = true;

  modules = {
    # Desktop Environment
    #dwl.enable = true;
    waybar.enable = true;
    mako.enable = true;
    tofi.enable = true;
    theme.enable = true;

    # CLI
    fish.enable = true;
    foot.enable = true;
    fastfetch.enable = true;
    webcam.enable = true;
    eza.enable = true;
    # mpd.enable = true;
    direnv.enable = true;
    git.enable = true;
    bat.enable = true;
    # neovim.enable = true;
    zoxide.enable = true;

    # GUI
    #vscode.enable = true;
    zed.enable = true;
  };

  home.stateVersion = "24.11";
  home.homeDirectory = lib.mkForce "/home/alex";

  sops = {
    defaultSopsFormat = "yaml";
    defaultSopsFile = ../../../secrets/default.yaml;
    age.keyFile = "/home/alex/.config/sops/age/keys.txt";
  };
}
