{config, ...}: {
  imports = [
    ../../modules/darwin
  ];

  users.users.alex = {
    name = "alex";
    home = "/Users/alex";
  };

  # Hostname
  networking = let
    name = "onyx";
  in {
    computerName = name;
    hostName = name;
    localHostName = name;
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

  programs.fish.enable = true; # everything explodes without this
  services.nix-daemon.enable = true;

  # Packages & Environment Variables
  environment = {
    variables = {
      HOMEBREW_NO_ENV_HINTS = "1";
    };
  };

  # Modules
  modules = {
    # Environment
    skhd.enable = true;
    yabai.enable = true;
    defaults.enable = true;
    security.enable = true;
    fonts.enable = true;

    # Homebrew - Manages the majority of my packages.
    homebrew.enable = true;
  };

  # State Version
  system.stateVersion = 4;
}
