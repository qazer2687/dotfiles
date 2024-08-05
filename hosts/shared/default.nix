{pkgs, ...}: {
  # User
  users.users.alex = {
    isNormalUser = true;
    extraGroups = ["networkmanager" "wheel" "video" "audio"];
    shell = pkgs.fish;
  };

  # Shell
  programs.fish.enable = true;


  # Dconf (gtk settings)
  programs.dconf.enable = true;

  # Systemd
  systemd.coredump.enable = false;

  # Environment
  environment = {
    sessionVariables = {
      GTK_THEME = "Adwaita-dark";
    };
  };
}
