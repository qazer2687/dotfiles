{config, lib, pkgs, ...}: {
  imports = [
    ../../modules/nixos-darwin
  ];

  nixpkgs.config.allowUnfree = mkDefault true;

  nix.settings = {
    experimental-features = mkDefault [
      "nix-command"
      "flakes"
    ];
    keep-derivations = mkDefault true;
    keep-outputs = mkDefault true;
    auto-optimise-store = mkDefault true;
    sandbox = mkDefault true;
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
