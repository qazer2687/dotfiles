{
  pkgs,
  ...
}: {
  # Imports
  imports = [
    ./hardware-configuration.nix
    ./modules.nix
  ];

  # Hostname
  networking.hostName = "jade";

  # Disable XWayland & Xorg
  programs.xwayland.enable = false;
  #services.xserver.enable = false;

  # XDG Portal
  xdg.portal = {
    enable = false;
    gtkUsePortal = true;
    #extraPortals = [ pkgs.obs-xdg-portal pkgs.xdg-desktop-portal-wlr ];
  };

  services.xserver.displayManager.sessionPackages = [ pkgs.sway ];

  environment.sessionVariables = {
    # General
    NIXOS_OZONE_WL = "1"; # Wayland Electron Support
    MOZ_ENABLE_WAYLAND = "1"; # Wayland Firefox Support
    

    # Fixes
    #GTK_USE_PORTAL = "0"; # Waybar Startup Delay Fix
    WLR_NO_HARDWARE_CURSORS = "1"; # Invisible Cursor Fix
    #ELECTRON_DISABLE_GPU = "1"; # Display Flickering Fix
  };

  # Startup Message
  environment.etc = {
    issue = {
      text = ''\e[32mWelcome to Jade!\e[0m'';
    };
  };

  # No Login Manager
  environment.loginShellInit = ''
    [[ "$(tty)" == /dev/tty2 ]] && sway --unsupported-gpu
  '';
}
