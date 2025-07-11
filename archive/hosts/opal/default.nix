{pkgs, ...}: {
  imports = [
    ../../hardware/opal
    ../../modules/base
  ];

  networking.hostName = "opal";

  users.users.alex = {
    isNormalUser = true;
    extraGroups = ["networkmanager" "wheel" "video"];
    hashedPassword = "$6$qRDf73LqqlnrtGKd$fwNbmyhVjAHfgjPpM.Wn8YoYVbLRq1oFWN15fjP3b.cVW8Dv3s/7q8NY4WBYY7x1Xe71S.AHpuqL1PY6IJe0x1";
    shell = pkgs.fish;
  };

  programs.fish.enable = true;

  boot = {
    kernelParams = [
      "quiet"
      "mitigations=off"

      # https://wiki.cachyos.org/configuration/general_system_tweaks/?utm_source=chatgpt.com#enable-rcu-lazy
      "rcutree.enable_rcu_lazy=1"
    ];
    blacklistedKernelModules = [
      # Disable the watchdog timer to stop
      # watchdog from hanging on poweroff.
      "iTCO_wdt"
      # Wi-Fi
      "iwlwifi"
      # Bluetooth
      "btusb"
    ];
    initrd.verbose = false;
    consoleLogLevel = 0;

    kernelPackages = pkgs.linuxPackages_cachyos;
  };

  services.scx.enable = true;

  # Prevent log files from becoming too large.
  services.journald.extraConfig = ''
    SystemMaxUse=100M
  '';

  networking.firewall = {
    enable = true;
    # I use a reverse proxy for everything but these things require ports to be open.
    allowedTCPPorts = [
      # SSH
      22
      # Caddy
      80
      81
      443
      # qBittorrent
      6881
      # Conduwuit (Matrix)
      8448
      # Minecraft
      25565
    ];
    allowedUDPPorts = [
      # qBittorrent
      6881
    ];
  };

  environment.systemPackages = with pkgs; [
    git
  ];

  programs.bash = {
    shellAliases = {
      "rebuild" = "sudo nixos-rebuild switch --flake github:qazer2687/dotfiles#$(hostname) --refresh --option eval-cache false";
    };
  };

  modules = {
    core.enable = true;
    zram.enable = true;
    docker.enable = true;
  };

  # Did you read the comment?
  system.stateVersion = "23.05";
}
