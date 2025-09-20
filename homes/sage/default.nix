{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ../../modules/home
  ];

  # Packages
  home.packages = with pkgs; [
    obsidian
    vlc
    loupe
    gdu
    btop
    protonvpn-gui
    nautilus
    killall

    lunar-client
  ];

  modules = {
    # Development
    direnv.enable = true;
    git.enable = true;

    # CLI
    eza.enable = true;
    zoxide.enable = true;
    utilities.enable = true;
    fish.enable = true;
    foot.enable = true;
    fastfetch.enable = true;

    # Theming
    fonts.enable = true;
    theme.enable = true;

    # Desktop Environment
    hyprland.enable = true;
    hyprlock.enable = true;
    waybar.enable = true;
    mako.enable = true;
    tofi.enable = true;

    # Applications
    firefox.enable = true;
    vesktop.enable = true;

    # Broken until I update jet when the firefox no playback issues are resolved.
    #vscode.enable = true;

    # Gaming
    mangohud.enable = true;
    prismlauncher.enable = true;
  };

  home.stateVersion = "25.05";
  home.homeDirectory = lib.mkForce "/home/alex";

  sops = {
    defaultSopsFormat = "yaml";
    defaultSopsFile = ../../../secrets/default.yaml;
    age.keyFile = "/home/alex/.config/sops/age/keys.txt";
  };
}
