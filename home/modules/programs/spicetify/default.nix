{
  pkgs,
  lib,
  inputs,
  config,
  ...
}: {
  options.homeModules.programs.spicetify.enable = lib.mkEnableOption "";

  config = lib.mkIf config.homeModules.programs.spicetify.enable {
    # Installation
    home.packages = with pkgs; [spotify];

    # Configuration
    imports = [inputs.spicetify-nix.homeManagerModule];

    programs.spicetify = let spicePkgs = inputs.spicetify-nix.packages.${pkgs.system}.default; in {
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