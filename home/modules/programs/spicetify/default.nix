{
  pkgs,
  lib,
  inputs,
  config,
  ...
}: {

  # Imports
  imports = [inputs.spicetify-nix.homeManagerModule];

  options.homeModules.programs.spicetify.enable = lib.mkEnableOption "";

  config = lib.mkIf config.homeModules.programs.spicetify.enable {
    # Configuration
    programs.spicetify = {
      enable = true;
      theme = inputs.spicetify-nix.packages.${pkgs.system}.default.themes.catppuccin-macchiato;
      colorScheme = "flamingo";
      enabledExtensions = with inputs.spicetify-nix.packages.${pkgs.system}.default.extensions; [
        hidePodcasts
        genre
        songStats
        volumePercentage
      ];
    };
  };
}