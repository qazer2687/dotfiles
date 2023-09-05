{...}: {
  # Imports
  imports = [
    ./hardware-configuration.nix
    ./modules.nix
  ];

  # Hostname
  networking.hostName = "ruby";

  # Disable XWayland & Xorg
  programs.xwayland.enable = false;
  services.xserver.enable = false;

  # Disable XDG Portal
  xdg.portal.enable = false;

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1"; # Wayland Electron Support
    MOZ_ENABLE_WAYLAND = "1";
    GTK_USE_PORTAL = "0"; # Waybar Startup Delay Fix
  };
  # Issue/MOTD
  environment.etc = {
    issue = {
      text = ''\e[31mWelcome to Ruby!\e[0m'';
    };
  };

  # No Login Manager
  environment.loginShellInit = ''
    [[ "$(tty)" == /dev/tty1 ]] && sway
  '';
}
