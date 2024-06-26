{
  config,
  pkgs,
  ...
}: {
  imports = [
    ../../modules/darwin
  ];

  networking = let
    name = "onyx";
  in {
    computerName = name;
    hostName = name;
    localHostName = name;
  };

  users.users.alex = {
    name = "alex";
    home = "/Users/alex";
    shell = pkgs.fish;
  };

  nixpkgs.config.allowUnfree = true;

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    keep-derivations = true;
    keep-outputs = true;
    auto-optimise-store = true;
    sandbox = true;
  };

  system.defaults.NSGlobalDomain.AppleShowAllExtensions = true;
  system.defaults.NSGlobalDomain._HIHideMenuBar = false;
  system.defaults.NSGlobalDomain."com.apple.swipescrolldirection" = false;
  system.defaults.dock.mru-spaces = false;
  system.defaults.finder.ShowStatusBar = false;

  system.defaults.dock = {
    autohide = true;
    autohide-delay = 1000.0;
  };

  services.nix-daemon.enable = true;

  ## requires manual chsh
  programs.fish.enable = true;

  security.pam.enableSudoTouchIdAuth = true;

  # Packages
  environment.systemPackages = with pkgs; [
    coreutils
    git
  ];

  # Modules
  modules = {
    # Environment
    skhd.enable = true;
    yabai.enable = true;
    fish.enable = true;

    # Homebrew
    homebrew.enable = true;
  };

  # Fonts
  fonts.packages = with pkgs; [
    (nerdfonts.override {
      fonts = [
        "FiraCode"
        "FiraMono"
        "Iosevka"
        "LiberationMono"
      ];
    })
    atkinson-hyperlegible
    noto-fonts-color-emoji
    noto-fonts-cjk-sans
  ];

  # State Version
  system.stateVersion = 4;
}
