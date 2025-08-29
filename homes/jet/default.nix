{
  lib,
  pkgs,
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
    gdu
    btop
    protonvpn-gui
    jetbrains.idea-community
  ];

  services.arrpc.enable = true;

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
    niri.enable = true;
    hyprland.enable = true;
    #hyprlock.enable = true;
    waybar.enable = true;
    mako.enable = true;
    tofi.enable = true;

    # Applications
    firefox.enable = true;
    vscode.enable = true;
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
