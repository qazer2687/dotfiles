{...}: {
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

  # Disable XDG Portal
  xdg.portal.enable = false;

  # Environment Variables
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1"; # Wayland Electron Support
    MOZ_ENABLE_WAYLAND = "1";
    GTK_USE_PORTAL = "0"; # Waybar Startup Delay Fix
  };

  # Startup Message
  environment.etc = {
    issue = {
      text = ''\e[32mWelcome to Jade!\e[0m'';
    };
  };
}
