{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ../../../hardware/jade
    ../../modules
  ];

  networking.hostName = "jade";

  users.users.alex = {
    isNormalUser = true;
    extraGroups = ["networkmanager" "wheel" "video"];
  };

  services.xserver.enable = true;	
  services.xserver.displayManager.sx.enable = true;

  environment.loginShellInit = ''
    [[ "$(tty)" == /dev/tty1 ]] && sx
  '';

  environment.systemPackages = with pkgs; [
    firefox
    obsidian
    vscodium-fhs
    gnome.nautilus
  ];
  
  modules = {
    herbstluftwm.enable = true;
    alacritty.enable = true;
    polybar.enable = true;
    bash.enable = true;
    kernel.enable = true;
    networkmanager.enable = true;
    nvidia.enable = true;
    pipewire.enable = true;
    prismlauncher.enable = true;
    systemd-boot.enable = true;
    zram.enable = true;
  };
}
