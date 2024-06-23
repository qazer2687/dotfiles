{config, lib, pkgs, ...}: {
  imports = [
    ../../modules/nixos-darwin
  ];

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
  system.defaults.NSGlobalDomain._HIHideMenuBar = true;
  system.defaults.NSGlobalDomain."com.apple.swipescrolldirection" = false;
  system.defaults.dock.autohide = true;
  system.defaults.dock.mru-spaces = false;
  system.defaults.finder.ShowStatusBar = false;

  services.nix-daemon.enable = true;

  environment.systemPackages = with pkgs; [
    coreutils
    git
  ];

  modules = {
    skhd.enable = true;
    yabai.enable = true;
  };
}
