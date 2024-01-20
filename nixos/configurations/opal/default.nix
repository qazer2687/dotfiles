{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ../../../hardware/opal
    ../../modules
  ];

  networking.hostName = "opal";

  users.users.alex = {
    isNormalUser = true;
    extraGroups = ["networkmanager" "wheel" "video"];
  };

  services.homepage-dashboard = {
    enable = true;
    openFirewall = true;
    listenPort = 80;
  };

  services.cockpit = {
    enable = true;
    openFirewall = true;
  };

  services.jellyfin = {
    enable = true;
    user = "alex";
    openFirewall = true;
  };

  environment.systemPackages = with pkgs; [
    qbittorrent-nox
    flood
  ];

  modules = {
    bash.enable = true;
    kernel.enable = true;
    networkmanager.enable = true;
    systemd-boot.enable = true;
    zram.enable = true;
  };
}
