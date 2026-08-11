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
    mpv
    gdu
    loupe
    btop
    nautilus
    neovim
    cryptsetup
    inputs.helium.packages.${pkgs.stdenv.hostPlatform.system}.default
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
    fastfetch.enable = true;

    # Theming
    fonts.enable = true;
    theme.enable = true;

    # Desktop Environment
    sway.enable = true;
    hyprlock.enable = true;
    mako.enable = true;
    tofi.enable = true;
    foot.enable = true;

    # Applications
    zed.enable = true;
    vesktop.enable = true;
  };

  home.stateVersion = "26.05";
  home.homeDirectory = lib.mkForce "/home/alex";

  sops = {
    defaultSopsFormat = "yaml";
    defaultSopsFile = ../../../secrets/default.yaml;
    age.keyFile = "/home/alex/.config/sops/age/keys.txt";
  };
}
