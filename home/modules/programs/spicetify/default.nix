{
  pkgs,
  lib,
  inputs,
  config,
  spicetify-nix,
  ...
}: {
  options.homeModules.programs.spicetify.enable = lib.mkEnableOption "";

  config = lib.mkIf config.homeModules.programs.spicetify.enable {
    # Installation
    home.packages = with pkgs; [spotify];

    # Configuration
    imports = [spicetify-nix.homeManagerModule];

    programs.spicetify = let spicePkgs = spicetify-nix.packages.${pkgs.system}.default; in {
      enable = true;
      theme = spicePkgs.themes.catppuccin-mocha;
      colorScheme = "flamingo";
      enabledExtensions = with spicePkgs.extensions; [
        fullAppDisplay
        shuffle # shuffle+ (special characters are sanitized out of ext names)
        hidePodcasts
      ];
    };
  };
}