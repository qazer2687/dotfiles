{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ../../../hardware/ruby
    ../../modules
  ];

  networking.hostName = "ruby";

  users.users.alex = {
    isNormalUser = true;
    extraGroups = ["networkmanager" "wheel" "video"];
  };

  environment.systemPackages = with pkgs; [
    firefox
    obsidian
    vscodium-fhs
    gnome.nautilus
  ];
  
  modules = {
    bash.enable = true;
    kernel.enable = true;
    waybar.enable = true;
    foot.enable = true;
    networkmanager.enable = true;
    sway.enable = true;
    pipewire.enable = true;
    systemd-boot.enable = true;
    zram.enable = true;
    tlp.enable = true;
  };
}
