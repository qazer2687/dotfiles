{
  lib,
  ...
}: {
  # Imports
  imports = [
    ./hardware-configuration.nix
    ./modules.nix
  ];

  # Hostname
  networking.hostName = "jade";

  # Disable XWayland & Xorg & XDG Portal
  programs.xwayland.enable = false;
  services.xserver.enable = lib.mkDefault false;
  xdg.portal.enable = false;

  # Environment Variables
  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1"; # Invisible Cursor Fix
    NIXOS_OZONE_WL = "1"; # Wayland Electron Support
    MOZ_ENABLE_WAYLAND = "1"; # Wayland Firefox Support
    GTK_USE_PORTAL = "0"; # Waybar Startup Delay Fix
    NIXPKGS_ALLOW_UNFREE = "1"; # Allow Unfree 'nix-shell' Packages
    #WLR_RENDERER= "vulkan"; # Wayland Flickering Fix
    
  };

  # Startup Message
  environment.etc = {
    issue = {
      text = ''\e[32mWelcome to Jade!\e[0m'';
    };
  };

  # No Login Manager
  environment.loginShellInit = ''
    [[ "$(tty)" == /dev/tty1 ]] && WLR_RENDERER=vulkan sway --unsupported-gpu
  '';
}
