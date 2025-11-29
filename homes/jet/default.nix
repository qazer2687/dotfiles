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
    vlc
    gdu
    btop
    #protonvpn-gui
    nautilus
    neovim
    cryptsetup
    gajim
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
    yazi.enable = true;

    # Theming
    fonts.enable = true;
    theme.enable = true;

    # Desktop Environment
    hyprland.enable = true;
    hyprlock.enable = true;
    waybar.enable = true;
    mako.enable = true;
    tofi.enable = true;
    hyprsunset.enable = true;

    # Applications
    firefox.enable = true;
    vscode.enable = true;
    zed.enable = true;
    vesktop.enable = true;

    # Games
    prismlauncher.enable = true;
  };

  home.stateVersion = "24.11";
  home.homeDirectory = lib.mkForce "/home/alex";

  sops = {
    defaultSopsFormat = "yaml";
    defaultSopsFile = ../../../secrets/default.yaml;
    age.keyFile = "/home/alex/.config/sops/age/keys.txt";
  };
}
